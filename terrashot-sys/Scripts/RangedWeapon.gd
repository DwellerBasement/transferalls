class_name RangedWeapon
extends Weapon

@export var ProjectileScene: PackedScene
@export var Damage: int = 10
@export var HitForce: int = 300
@export var ProjectileSpeed: float = 600.0

@onready var Anim: AnimationPlayer = $AnimationPlayer
@onready var SpawnPoint: Marker2D = $SpawnPoint

func _Equip():
	pass

func _UnEquip():
	pass

func _Use():
	IsAttacking = true
	_SpawnProjectile()
	Anim.play("Shoot")
	await Anim.animation_finished
	IsAttacking = false

func _SpawnProjectile():
	var projectile = ProjectileScene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.global_position = SpawnPoint.global_position
	projectile.direction = Vector2.RIGHT.rotated(global_rotation)
	projectile.speed = ProjectileSpeed
	projectile.damage = Damage
	projectile.hit_force = HitForce
