extends CharacterBody2D
@export var gravity = 600.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var SPEED := 200
@export var JUMP_SPEED := -400
@onready var animplayer = $AnimatedSprite2D

const UP = Vector2(0,-1)

func _get_input():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED

  # Get the input direction and handle the movement/deceleration.
  # As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var animation = "idle"
	if direction:
		animation = "walk right"
		velocity.x = direction * SPEED
		if direction>0:
			animplayer.flip_h = false
		else:
			animplayer.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if animplayer.animation!=animation:
		animplayer.play(animation)
	move_and_slide()


func _physics_process(delta: float) -> void:
	velocity.y += delta * gravity

	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		velocity.y = jump_speed

	if Input.is_action_pressed("ui_left"):
		velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  walk_speed
	else:
		velocity.x = 0

	# "move_and_slide" already takes delta time into account.
	move_and_slide()
