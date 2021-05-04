extends ColorRect

export var health = 100 setget _set_health, _get_health
export var hidden = false


func _ready():
	hidden
	pass


func _set_health(newHealth):
	health = newHealth


func _get_health():
	return health


func _hide():
	hidden = true
	visible = false


func _show():
	hidden = false
	visible = true
