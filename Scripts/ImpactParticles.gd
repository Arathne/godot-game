extends CPUParticles


func _ready():
	restart()
	$Timer.connect("timeout", self, "_destroy_particles")


func _destroy_particles():
	queue_free()
