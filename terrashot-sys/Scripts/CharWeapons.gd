class_name CharacterWeapons
extends Node2D

@export var WeaponEquip: PackedScene
var CurrentWeapon = null

func _ready():
	Global.Player = get_parent()
	if WeaponEquip:
		EquipWeapon(WeaponEquip)

func EquipWeapon(WeaponScene: PackedScene):
	if CurrentWeapon:
		UnequipWeapon()

	CurrentWeapon = WeaponScene.instantiate()
	add_child(CurrentWeapon)
	CurrentWeapon.global_position = global_position
	CurrentWeapon.set("OwnerChar", Global.Player)
	CurrentWeapon.call("_Equip")

func UnequipWeapon():
	if not CurrentWeapon:
		return

	CurrentWeapon._UnEquip()
	CurrentWeapon.queue_free()
	CurrentWeapon = null
