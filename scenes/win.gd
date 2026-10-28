extends Control

const MAIN_SCENE_PATH = "res://scenes/main.tscn"

func _ready() -> void:
	var play_button = get_node_or_null("VBoxContainer/Button")

	if play_button == null:
		push_error("Nie znaleziono przycisku!")
		return

	if not play_button.pressed.is_connected(_on_play_again_pressed):
		play_button.pressed.connect(_on_play_again_pressed)

	print("Przycisk podłączony poprawnie")


func _on_play_again_pressed() -> void:
	print("Kliknięto Zagraj ponownie")
	print("Istnieje scena: ", ResourceLoader.exists(MAIN_SCENE_PATH))

	Global.crystals = 0
	Global.max_crystals = 2
	get_tree().paused = false

	var error = get_tree().change_scene_to_file(MAIN_SCENE_PATH)

	print("Wynik zmiany sceny: ", error)

	if error != OK:
		push_error("Błąd wczytywania: " + error_string(error))
