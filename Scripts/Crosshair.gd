extends Spatial

var offset = 0 setget _set_offset, _get_offset

func _set_offset(newOffset):
	offset = newOffset
	for line in get_children():
		line.rect_position = line.original_position + line.direction * offset

func _get_offset():
	return offset
