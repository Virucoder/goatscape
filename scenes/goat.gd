extends CharacterBody2D

@export var speed: float = 100.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing: String = "d"

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = input_dir * speed
	move_and_slide()

	if input_dir.x < 0:
		facing = "a"
	elif input_dir.x > 0:
		facing = "d"

	if input_dir != Vector2.ZERO:
		play_if_exists("walk_" + facing)
	else:
		play_if_exists("idle_" + facing)


func play_if_exists(animation_name: String) -> void:
	if sprite.sprite_frames.has_animation(animation_name):
		if sprite.animation != animation_name or not sprite.is_playing():
			sprite.play(animation_name)
