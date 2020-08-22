extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1400
export (int) var gravity = 4000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25



var velocity = Vector2.ZERO

func get_input():
	var dir = 0
	if Input.is_action_pressed("player_right"):
		$AnimatedSprite.play("right")
		dir += 1
	if Input.is_action_pressed("player_left"):
		$AnimatedSprite.play("left")
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		$AnimatedSprite.play("idle")
		velocity.x = lerp(velocity.x, 0, friction)
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = jump_speed
		
	
