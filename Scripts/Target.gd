extends KinematicBody

var animation_player
var active = false

var collision1
var collision2
var collision3

func _ready():
	animation_player = get_node("AnimationPlayer")
	animation_player.play("Fall")
	
	collision1 = get_node("CollisionShape")
	collision2 = get_node("CollisionShape2")
	collision3 = get_node("CollisionShape3")
	_raise()

func _disable_collisions():
	collision1.disabled = true
	collision2.disabled = true
	collision3.disabled = true
	
func _enable_collisions():
	collision1.disabled = false
	collision2.disabled = false
	collision3.disabled = false

func _fall():
	if active:
		_disable_collisions()
		active = false
		animation_player.play("Fall")
	
func _raise():
	_enable_collisions()
	active = true
	animation_player.play("Raise")
