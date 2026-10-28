extends StaticBody2D

@onready var anim: AnimatedSprite2D = $SleepingDragon

var waking_up: bool = false

func _ready() -> void:
	print("SMOK: gotowy")
	anim.play("sleep")

	if not Global.time_finished.is_connected(wake_up):
		Global.time_finished.connect(wake_up)

func wake_up() -> void:
	if waking_up:
		return

	waking_up = true
	print("SMOK: czas na pobudkę!")

	var camera := get_tree().get_first_node_in_group("player_camera") as Camera2D

	if camera != null:
		camera.enabled = true
		camera.make_current()

		var tween := create_tween()
		tween.tween_property(
			camera,
			"global_position",
			global_position,
			1.5
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

		await tween.finished
	else:
		print("UWAGA: nie znaleziono kamery player_camera")

	if not anim.sprite_frames.has_animation("wakey"):
		print("BŁĄD: brak animacji wakey")
		return

	anim.sprite_frames.set_animation_loop("wakey", false)
	anim.play("wakey")

	await anim.animation_finished

	var current_scene = get_tree().current_scene
	var hud = current_scene.find_child("HUD", true, false)

	if hud != null and hud.has_method("show_reset_message"):
		hud.show_reset_message()

	await get_tree().create_timer(3.0).timeout

	Global.crystals = 0
	get_tree().reload_current_scene()
