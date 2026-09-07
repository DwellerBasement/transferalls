class_name PlayerWeapons
extends CharacterWeapons

@export var MeleeScene: PackedScene
@export var RangedScene: PackedScene
var UsingMelee: bool = true

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	var MousePos: Vector2 = get_global_mouse_position()
	var MouseDir: Vector2 = global_position.direction_to(MousePos)

	if Input.is_action_just_pressed("Q"):
		_SwapWeapon()

	if CurrentWeapon:
		CurrentWeapon.SetAimDir(MouseDir)
		if Input.is_action_just_pressed("LeftClick"):
			CurrentWeapon._TryUse()

func _SwapWeapon():
	UsingMelee = !UsingMelee
	if UsingMelee:
		EquipWeapon(MeleeScene)
	else:
		EquipWeapon(RangedScene)
