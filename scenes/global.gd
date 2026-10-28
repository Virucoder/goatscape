extends Node

signal crystals_changed(current: int, maximum: int)
signal time_finished

var crystals: int = 0
var max_crystals: int = 2

func add_crystal() -> void:
	if crystals < max_crystals:
		crystals += 1
		crystals_changed.emit(crystals, max_crystals)
		print("Kryształy: ", crystals, "/", max_crystals)

func finish_time() -> void:
	print("GLOBAL: koniec czasu — wysyłam sygnał")
	time_finished.emit()
