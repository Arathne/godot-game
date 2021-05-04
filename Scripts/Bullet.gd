extends KinematicBody

var timer
var speed = 1000
var velocity = Vector3.ZERO

func _ready():
	timer = get_node("Timer")
	timer.connect("timeout", self, "_on_timeout")

func _physics_process(delta):
	velocity = -transform.basis.z * speed
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.is_in_group("Enemy"):
			if collision.collider.active:
				collision.collider._fall()
		
		queue_free()
	

func _on_timeout():
	queue_free()
