extends Sprite2D

@export var spikes: Array[Node2D] = []
@export var start_on: bool = true

var switch: bool = false

func _ready() -> void:
	switch = start_on

	if switch:
		on()
	else:
		off()

func interact() -> void:
	switch = not switch

	if switch:
		on()
	else:
		off()

	update_spikes()

func on() -> void:
	frame = 26

func off() -> void:
	frame = 25

func update_spikes() -> void:
	for spike_group in spikes:
		if not is_instance_valid(spike_group):
			continue

		for spike in spike_group.get_children():
			if spike.has_method("spikes_on") and spike.has_method("spikes_off"):
				if spike.is_on:
					spike.spikes_off()
				else:
					spike.spikes_on()
