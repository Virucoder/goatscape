extends Sprite2D

const WIN_SCENE_PATH = "res://scenes/Win.tscn"

var is_open: bool = false

func _ready() -> void:
	is_open = false
	frame = 14
	print("DRZWI: zamknięte i czekają na E")

func interact() -> void:
	print("DRZWI: wywołano interact()")

	if is_open:
		return

	if Global.crystals < Global.max_crystals:
		print("Za mało kryształów: ",
			Global.crystals, "/", Global.max_crystals)
		return

	is_open = true
	frame = 23
	print("DRZWI: gracz otworzył drzwi")

	var collision = get_node_or_null("%DoorColision")
	if collision != null:
		collision.set_deferred("disabled", true)

	await get_tree().create_timer(0.5).timeout

	print("DRZWI: przechodzę do ", WIN_SCENE_PATH)

	var error = get_tree().change_scene_to_file(WIN_SCENE_PATH)
	if error != OK:
		is_open = false
		push_error("Błąd przejścia do Win.tscn: " + str(error))
