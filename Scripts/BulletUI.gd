extends Control

var bullets
var ammo = 0 setget _set_ammo, _get_ammo_count
var animation_player


func _ready():
	animation_player = get_parent().get_node("AnimationPlayer")
	animation_player.connect("animation_finished", self, "_reload_animation_finished")
	bullets = get_children()
	ammo = bullets.size()
	_set_ammo(-1)


func _hide_all():
	for texture in bullets:
		texture.visible = false


func hide_(index):
	bullets[index].visible = false


func _show_all():
	for texture in bullets:
		texture.visible = true


func _show(index):
	bullets[index].visible = true


func _set_ammo(value):
	if value >= 0 and value <= bullets.size():
		ammo = value
		_hide_all()
		for i in ammo:
			_show(i)


func _get_ammo_count():
	return ammo


func _consume_ammo():
	_set_ammo(ammo - 1)


func _is_empty():
	if ammo <= 0:
		return true
	return false

func _reload_animation_finished(animation_name):
	if animation_name == "Reload":
		ammo = bullets.size()
		_show_all()
