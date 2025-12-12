extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Gravitydsad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * SPEED if direction else move_toward(velocity.x, 0, SPEED)

	# Flip sprite
	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false

	# ANIMATION LOGIC
	if not is_on_floor():
		anim.play("jump")
	else:
		if direction != 0:
			anim.play("walk")
		else:
			anim.play("idle")

	move_and_slide()
