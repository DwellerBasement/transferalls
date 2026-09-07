class_name MeleeWeapon
extends Weapon

@export var Damage: int
@export var HitForce: int

@onready var Anim: AnimationPlayer = $AnimationPlayer
@onready var HitBox: Area2D = $HitBox

func _ready():
	HitBox.monitoring = false
	HitBox.body_entered.connect(_on_hit)

func _Equip():
	HitBox.monitoring = false

func _UnEquip():
	HitBox.monitoring = false
	IsAttacking = false

func _Use():
	IsAttacking = true
	Anim.play("Attack")
	HitBox.monitoring = true
	await Anim.animation_finished
	HitBox.monitoring = false
	IsAttacking = false

func _on_hit(body: Node2D):
	if body.has_method("TakeDamage"):
		var knockback = global_position.direction_to(body.global_position) * HitForce
		body.TakeDamage(Damage, knockback)
