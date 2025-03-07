extends CharacterBody2D

@export var JUMP_VELOCITY = -300
@export var SPEED = 200
@export var MAX_HEALTH = 10

enum {
	ATTACKING, 						# 0
	DOUBLE_ATTACKING, 		# 1
	CLIMBING,							# 2 
	DYING, 								# 3
	HURTING, 							# 4
	IDLING,								# 5
	JUMPING,							# 6
	DOUBLE_JUMP,					# 7
	PUSHING,							# 8
	RUNNING,							# 9
	THROWING,							# 10
	WALKING,							# 11
	WALKING_AND_ATTACKING	# 12
}

var state = [IDLING]
var health = MAX_HEALTH

var hurt_timeout: float = 0.5

func push_state(new_state):
	state.push_back(new_state)
	print("Pushed: " + str(new_state))

func pop_state():
	state.pop_back()
	print("Popped: " + str(state[-1]))

func timeout_pop():
	pop_state()


@onready var character_animation: AnimatedSprite2D = $AnimatedCharacterSprite
@onready var collider: Area2D = $Area2D


func _process(delta: float) -> void:
	var last_state = state[-1]
	match last_state:
		ATTACKING:
			character_animation.play("attack1")
		DOUBLE_ATTACKING:
			character_animation.play("attack2")
		CLIMBING:
			character_animation.play("climb")
		DYING:
			character_animation.play("death")
		HURTING:
			pass
		IDLING:
			character_animation.play("idle")
			if (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and not (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right")):
				push_state(RUNNING)
			elif Input.is_action_just_pressed("ui_up"):
				push_state(JUMPING)	
				velocity.y = JUMP_VELOCITY
		JUMPING:
			character_animation.play("jump")
			if is_on_floor():
				pop_state()
			elif Input.is_action_just_pressed("ui_up"):
				push_state(DOUBLE_JUMP)
				velocity.y = JUMP_VELOCITY
			elif (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and not (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right")):
				var direction = int(Input.get_axis("ui_left", "ui_right"))
				velocity.x = direction * SPEED

				if direction > 0:
					character_animation.flip_h = false
				elif direction < 0:
					character_animation.flip_h = true
			else:
				velocity.x = 0
			
		DOUBLE_JUMP:
			character_animation.play("jump")
			if is_on_floor():
				pop_state()
				pop_state()
		PUSHING:
			character_animation.play("push")
		RUNNING:
			character_animation.play("run")
			var direction: int = int(Input.get_axis("ui_left", "ui_right"))
			velocity.x = direction * SPEED

			if direction > 0:
				character_animation.flip_h = false
			elif direction < 0:
				character_animation.flip_h = true

			if not (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
				velocity.x = 0
				pop_state()
			elif Input.is_action_just_pressed("ui_up"):
				velocity.y = -300
				push_state(JUMPING)
			elif velocity.x == 0:
				character_animation.play("idle")
		THROWING:
			character_animation.play("throw")
		WALKING:
			character_animation.play("walk")
		WALKING_AND_ATTACKING:
			character_animation.play("walk+attack")

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("area")
