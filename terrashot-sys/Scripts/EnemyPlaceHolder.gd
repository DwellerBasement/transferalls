extends CharacterBody2D 

enum State {Chase, Stun, Patrol} 

@export var friction: float = -400 # lower = more kb
@export var StunDuration: float = 0.25 
@export var hp: int = 60
@export var PatrolSpeed = 130 # lower = slower
@export var ChaseSpeed = 230 # lower = slower

@export var PatPoint1: Area2D
@export var PatPoint2: Area2D

var StunTimer: float = 0.0 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
var CurState: State = State.Chase
var Pos = self.global_position
var CurrentPatPoint = null

func _ready() -> void:
	CurrentPatPoint = PatPoint1	

	if PatPoint1:
		PatPoint1.body_entered.connect(_on_patrol_point1_entered)
	if PatPoint2:
		PatPoint2.body_entered.connect(_on_patrol_point2_entered)

func _on_patrol_point1_entered(body):
	CurrentPatPoint = PatPoint2
	
func _on_patrol_point2_entered(body):
	CurrentPatPoint = PatPoint1

func _physics_process(delta): 
	if not is_on_floor(): 
		velocity.y += gravity * delta 
		
	match CurState: 
		State.Chase: 
			_process_Chase(delta) 
		State.Stun: 
			_process_Stun(delta) 
		State.Patrol:
			_process_Patrol(delta)
			
	move_and_slide() 

func _process_Chase(delta: float) -> void: 
	
	$AnimatedSprite2D.play("chasing")
	
	if not Global.Player or not is_instance_valid(Global.Player): 
		CurState = State.Patrol
		return 
		
	var Dir = global_position.direction_to(Global.Player.global_position) 
	velocity.x = Dir.x * ChaseSpeed
	
	var Dist = global_position.distance_to(Global.Player.global_position) 
	if Dist >= 270: # higher = further distance required to partol
		CurState = State.Patrol

func _process_Stun(delta: float) -> void: 
	
	$AnimatedSprite2D.play("damaged")
	
	velocity.x = move_toward(velocity.x, 0, friction * delta) 
	StunTimer -= delta 
	if StunTimer <= 0: 
		CurState = State.Chase 

func _process_Patrol(delta: float) -> void: 
	
	$AnimatedSprite2D.play("patrol")
		
	var Dist = global_position.distance_to(Global.Player.global_position) 
	
	if not CurrentPatPoint:
		return
		
	var dir = global_position.direction_to(CurrentPatPoint.global_position)
	
	velocity.x = dir.x * PatrolSpeed

	if dir.x > 0:
		$AnimatedSprite2D.flip_h = false 
	elif dir.x < 0:
		$AnimatedSprite2D.flip_h = true  
	
	if Dist < 270:
		CurState = State.Chase
		

func TakeDamage(damage: int, knockback: Vector2): 
	hp -= damage 
	velocity = knockback 
	StunTimer = StunDuration 
	CurState = State.Stun 
	if hp <= 0: 
		queue_free()
