extends CharacterBody2D

# Setup variables
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var acceleration: float = 1000.0
@export var friction: float = 1000.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

@export var Inv: Inv

func _ready() -> void:
	Global.PlayerHp = 5
	
func collect(Item):
	Inv.insert(Item)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("A", "D")

	if direction != 0:
		animated_sprite.flip_h = (direction < 0)

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()
