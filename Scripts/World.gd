extends Spatial

var laserTemplate

var player
var playerSpawn
var laserSpawns

export var laser_playback_speed = 0.5


func _ready():
	$StartTime.connect("timeout", self, "_start_time_timeout")
	$SpawnTime.connect("timeout", self, "_spawn_time_timeout")
	
	laserTemplate = preload("res://Scene/Laser.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player = $Player
	playerSpawn = $PlayerSpawn
	laserSpawns = [$FrontLaserSpawn, $BackLaserSpawn]
	player.global_transform = playerSpawn.global_transform


func _spawn_laser():
	var random = randi() % laserSpawns.size()
	var spatial = laserSpawns[random]
	
	var newLaserInstance = laserTemplate.instance()
	spatial.add_child(newLaserInstance)
	newLaserInstance._play_random_animation(laser_playback_speed)


func _start_time_timeout():
	print("BEGIN")
	var canSpawnLasers = true
	$StartTime.disconnect("timeout", self, "start_time_timeout")
	$SpawnTime.start()
	_spawn_laser()


func _spawn_time_timeout():
	print("SPAWN")
	_spawn_laser()
	$SpawnTime.start()
	


func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
