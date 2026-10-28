extends Sprite2D

var switch: bool = false
var crystal_collected: bool = false

func interact() -> void:
	if crystal_collected:
		return

	if not switch:
		switch = true
		open()
	else:
		Global.add_crystal()
		crystal_collected = true
		switch = false
		closed()

func closed() -> void:
	frame = 21

func open() -> void:
	frame = 22
