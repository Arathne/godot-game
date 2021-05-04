extends KinematicBody

#var rng = RandomNumberGenerator.new()

export var developer = false

export var max_health = 100 setget _set_max_health, _get_max_health
var health = 100


func _ready():
	randomize()
	if developer:
		_disable_collision()


func _set_max_health(newHealth):
	max_health = newHealth


func _get_max_health():
	return max_health


func _hit(hitPoints):
	health -= hitPoints
	if _is_destroyed():
		queue_free()


func _is_destroyed():
	if health <= 0:
		return true
	return false


func _play_random_animation(speed):
	$Body.visible = true
	$CollisionShape.disabled = false
	var list = $AnimationPlayer.get_animation_list()
	var random = randi() % list.size()
	var animation_name = list[random]
	$AnimationPlayer.play(animation_name)
	$AnimationPlayer.playback_speed = speed
	$AnimationPlayer.connect("animation_finished", self, "_animation_finished")


func _animation_finished(animation_name):
	queue_free()


func _disable_collision():
	$CollisionShape.visible = false
