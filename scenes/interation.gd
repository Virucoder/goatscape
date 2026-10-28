extends Area2D

var can_interact: bool = false:
	set(value):
		can_interact = value
		$Label.visible = value

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		can_interact = true
		print("W pobliżu: ", owner.name)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		can_interact = false

func interaction() -> void:
	if owner != null and owner.has_method("interact"):
		print("E naciśnięte przy: ", owner.name)
		owner.interact()
	else:
		print("BŁĄD: owner nie ma funkcji interact()")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		interaction()
