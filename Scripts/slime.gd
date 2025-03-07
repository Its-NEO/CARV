extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var vision = $PlayerVision
@onready var self_collision = $SelfCollision

var target: Node2D = null

enum {IDLE, FOLLOW, HIT, DIE, ATTACK}
var state = [IDLE]

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _process(delta: float) -> void:
	match state:
		IDLE:
			pass
		FOLLOW:
			var direction = (target.global_position - global_position).x / abs(target.global_position - global_position).normalized()
			velocity.x = direction * SPEED
		ATTACK:
			pass
		DIE:
			pass
		HIT:
			pass


func _on_player_vision_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		state.push_back(FOLLOW)
		target = body
		print("Following Player...")

func _on_player_vision_body_exited(body:Node2D) -> void:
	if body.is_in_group("player"):
		state.pop_back()
		print("Stopped Following Player...")


func _on_self_collision_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		state.push_back(ATTACK)
		print("Attacking Player...")

func _on_self_collision_body_exited(body:Node2D) -> void:
	if body.is_in_group("player"):
		state.pop_back()
		print("Stopped Attacking Player...")



