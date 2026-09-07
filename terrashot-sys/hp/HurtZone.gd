extends Area2D

@onready var timer = $Timer

func _ready() -> void:
	Global.PlayerHp = 5

func _process(_delta: float) -> void:
	if Global.PlayerHp <= 0:
		get_tree().reload_current_scene()

func _on_body_entered(body: Node2D) -> void:
	Global.PlayerHp -= 1
	timer.start()

func _on_body_exited(body: Node2D) -> void:
	timer.stop()

func _on_timer_timeout() -> void:
	Global.PlayerHp -= 1
