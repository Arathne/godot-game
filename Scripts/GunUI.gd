extends Sprite3D

var right_gun_ammo
var left_gun_ammo


# Called when the node enters the scene tree for the first time.
func _ready():
	right_gun_ammo = $RightGun
	left_gun_ammo = $LeftGun


func _set_right_gun_ammo(value):
	right_gun_ammo.ammo = value


func _get_right_gun_ammo():
	return right_gun_ammo.ammo


func _set_left_gun_ammo(value):
	left_gun_ammo.ammo = value


func _get_left_gun_ammo():
	return left_gun_ammo.ammo

