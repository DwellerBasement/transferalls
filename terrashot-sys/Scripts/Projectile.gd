class_name Projectile
extends Area2D

var direction: Vector2
var speed: float
var damage: int
var hit_force: int
var lifetime: float = 3.0

func _ready():
	monitoring = false
	await get_tree().create_timer(0.1).timeout
	monitoring = true
	body_entered.connect(_on_hit)
	await get_tree().create_timer(lifetime).timeout
	if is_instance_valid(self):
		queue_free()

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_hit(body: Node2D):
	if body.has_method("TakeDamage"):
		var knockback = direction * hit_force
		body.TakeDamage(damage, knockback)
	queue_free()
