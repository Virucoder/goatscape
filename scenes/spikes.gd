extends Sprite2D

@export var start_on: bool = true

var is_on: bool = false

func _ready() -> void:
	if start_on:
		spikes_on()
	else:
		spikes_off()

func spikes_off() -> void:
	is_on = false
	frame = 19
	%SpikesColision.set_deferred("disabled", true)

func spikes_on() -> void:
	is_on = true
	frame = 24
	%SpikesColision.set_deferred("disabled", false)
