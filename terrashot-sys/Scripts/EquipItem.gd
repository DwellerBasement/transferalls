class_name EquipItem
extends Node2D

var LastUsed: float 
@export var UseRate: float = 0.5
var AimAngle: float 
var OwnerChar: CharacterBody2D
var CanUse : bool = true
var IsAttacking : bool = false

# EquipItem.gd
func _process(delta: float):
	global_rotation = lerp_angle(global_rotation, AimAngle, 40 * delta)
	if $Sprite2D:
		$Sprite2D.flip_v = abs(AimAngle) > PI / 2

func SetAimDir (AimDir : Vector2):
	AimAngle = AimDir.angle()

func _Equip():
	pass

func _UnEquip():
	pass

func _Use():
	pass

func _TryUse():
	if not CanUse:
		return false

	if Time.get_unix_time_from_system() - LastUsed < UseRate:
		return false

	LastUsed = Time.get_unix_time_from_system()
	_Use()

	return true
