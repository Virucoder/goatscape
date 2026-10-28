extends CanvasLayer

@onready var crystal_label: Label = $MarginContainer/HBoxContainer/CrystalLabel
@onready var timer_label: Label = $MarginContainer/HBoxContainer/TimerLabel
@onready var reset_message: Label = $ResetMessage

var time_left: float = 60.0
var time_is_over: bool = false

func _ready() -> void:
	reset_message.visible = false

	if not Global.crystals_changed.is_connected(update_crystals):
		Global.crystals_changed.connect(update_crystals)

	update_crystals(Global.crystals, Global.max_crystals)
	update_timer_label()

func _process(delta: float) -> void:
	if time_is_over:
		return

	time_left = maxf(time_left - delta, 0.0)
	update_timer_label()

	if time_left <= 0.0:
		time_is_over = true
		set_process(false)
		print("HUD: czas minął")
		Global.finish_time()

func update_crystals(current: int, maximum: int) -> void:
	crystal_label.text = "💎 %d/%d" % [current, maximum]

func update_timer_label() -> void:
	var total_seconds: int = int(ceil(time_left))
	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60

	timer_label.text = "⏱️ %02d:%02d" % [minutes, seconds]

func show_reset_message() -> void:
	reset_message.text = "SMOK SIĘ OBUDZIŁ!\nPoziom zostanie zresetowany..."
	reset_message.visible = true
