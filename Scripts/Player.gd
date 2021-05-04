extends KinematicBody

var velocity = Vector3.ZERO
export var speed = 10
export var normal_speed = 10
export var jump_speed = 1.75
export var shooting_speed = 0.5
export var rotate_speed = 2
export var gravity = -0.075

var aiming = false

var head
var guns
var raycast
var impact_particles
var camera_original_position

var rng = RandomNumberGenerator.new()


func _ready():
	$ShootMovementTime.connect("timeout", self, "_shoot_movement_time_end")
	$AimingTime.connect("timeout", self, "_aiming_movement_time_end")
	$CameraShakeTime.connect("timeout", self, "_camera_shake_time_end")
	camera_original_position = get_node("Head/Camera").transform.origin
	impact_particles = preload("res://Scene/ImpactParticles.tscn")
	guns = get_node("Head/Guns")
	head = get_node("Head")
	raycast = get_node("Head/Camera/RayCast")
	rng.randomize()


func _physics_process(delta):
	# reset velocity
	velocity = Vector3(0, velocity.y + gravity, 0)
	
	# strafe
	if Input.is_action_pressed("move_forward"):
		velocity -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		velocity += transform.basis.z
	if Input.is_action_pressed("move_left"):
		velocity -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		velocity += transform.basis.x
	
	# fire
	if Input.is_action_just_pressed("shoot"):
		if not guns._is_current_gun_playing_animation():
			if guns._is_empty() == false:
				# reduce movement speed
				$ShootMovementTime.start()
				speed = normal_speed * shooting_speed
				
				# emit sparks
				var point = raycast.get_collision_point()
				var sparks = impact_particles.instance()
				get_parent().add_child(sparks)
				sparks.global_transform.origin = point
				sparks.restart()
				
				# update UI
				$UI._animate_crosshair()
				guns.shoot = true
				
				# play sound for gun
				get_node("GunshotSound").play()
				
				# camera shake
				get_node("Head/Camera").fov = 70 - 2
				$CameraShakeTime.stop()
				$CameraShakeTime.start()
				
				# bullet hitting laser
				var rayCollision = raycast.get_collider()
				if rayCollision:
					if rayCollision.is_in_group("Laser"):
						rayCollision._hit(51)
						sparks.color = Color(0.0, 1.0, 0.0, 1.0)
	
	# crouch
	var capsule = $CollisionCapsule
	var crouch_collision = $CollisionCrouch
	var crouch_offset = -0.8
	if Input.is_action_just_pressed("crouch"):
		capsule.disabled = true
		crouch_collision.disabled = false
		head.global_transform.origin.y += crouch_offset
		print("pressed")
		
	
	if Input.is_action_just_released("crouch"):
		capsule.disabled = false
		crouch_collision.disabled = true
		head.global_transform.origin.y -= crouch_offset
		print("released")
	
	# aiming
	if Input.is_action_just_pressed("aiming"):
		aiming = true
		get_node("Head/Camera").transform.origin = camera_original_position + Vector3(0,0,-0.25)
		if not is_on_floor():
			$AimingTime.start()
		
	if Input.is_action_just_released("aiming"):
		aiming = false
		get_node("Head/Camera").transform.origin = camera_original_position
	
	# reload
	if Input.is_action_just_pressed("reload"):
		guns.reload = true
	
	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	if aiming:
		velocity = velocity * 0.7
	
	# move player
	move_and_slide(velocity * speed, Vector3.UP)
	
	# collisions with player
	var slide_count = get_slide_count()
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		if collision.get_collider().is_in_group("Laser"):
			get_tree().quit()


func _camera_shake_time_end():
	get_node("Head/Camera").fov = 70


func _shoot_movement_time_end():
	speed = normal_speed


func _aiming_movement_time_end():
	print("done")
	get_node("Head/Camera").transform.origin = camera_original_position
	aiming = false


var previous
func _input(event):
	if event is InputEventMouseMotion:
		previous = event.relative
		rotate_y(-rotate_speed * event.relative.x / 1000)
		head.rotate_x(-rotate_speed * event.relative.y / 1000)
