extends ColorRect

var original_position = Vector2.ZERO
export var direction = Vector2(0, 1)

func _ready():
	original_position = rect_position
