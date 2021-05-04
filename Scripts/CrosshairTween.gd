extends Tween

var crosshair

var start_offset_min = 15
var start_offset_max = 30
var time = 0.3

func _ready():
	crosshair = get_parent().get_node("Crosshair")

func _animate():
	remove_all()
	var random_offset = randi() % (start_offset_max - start_offset_min + 1) + start_offset_min
	self.interpolate_property(crosshair, "offset", random_offset, 0, time)
	self.start()
