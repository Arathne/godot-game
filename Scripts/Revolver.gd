extends KinematicBody

var fire = false setget _fire, _is_firing
var reload = false setget _reload, _is_reloading


func _fire(firing):
	if firing:
		fire = true
		$CPUParticles.restart()
		$AnimationPlayer.play("Shoot")
		fire = false


func _is_firing():
	return fire


func _reload(reloading):
	if reloading:
		$AnimationPlayer.play("Reload")


# returns true if the current weapon is in the reloading animation
func _is_reloading():
	return reload

func _is_playing_animation():
	if $AnimationPlayer.is_playing():
		return true
	return false
