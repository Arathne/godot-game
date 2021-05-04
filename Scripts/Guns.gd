extends Spatial

var shoot = false setget _shoot, _is_shooting
var reload = false setget _reload, _is_reloading
var current_gun
var index = 0

func _ready():
	current_gun = get_children()[index]


func _shoot(shooting):
	if shooting == true:
		var array = get_children()
		var gun = array[index]
		if gun.get_node("BulletUI").ammo > 0:
			gun.fire = true
			gun.get_node("BulletUI")._consume_ammo()
			
			index += 1
			if index > array.size() - 1:
				index = 0
			
			current_gun = array[index]


func _is_shooting():
	return shoot


func _ammo_left():
	var total_ammo = 0
	for gun in get_children():
		total_ammo += gun.get_node("BulletUI").ammo
	return total_ammo


func _is_empty():
	if _ammo_left() <= 0:
		return true
	return false


func _reload(reloading):
	if reloading:
		for gun in get_children():
			gun.reload = true


func _is_reloading():
	return reload


func _is_current_gun_playing_animation():
	return current_gun._is_playing_animation()
