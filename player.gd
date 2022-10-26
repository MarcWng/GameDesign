extends KinematicBody2D

var velocity = Vector2.ZERO
export(int) var JUMP_STRENGTH = 700
export(int) var GRAVITY = 50
func get_input():
	velocity.x = 0
	if Input.is_action_pressed('right'):
		$AnimatedSprite.play("walk")
		velocity.x += 200
	if Input.is_action_pressed('left'):
		$AnimatedSprite.play("walk")
		velocity.x -= 200
	if Input.is_action_pressed('space') && is_on_floor():
		velocity.y = -JUMP_STRENGTH
		$JumpSound.play()
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	if velocity.x == 0:
		$AnimatedSprite.play("still")
	if is_on_floor() == false && velocity.y <= 0:
		$AnimatedSprite.play("jump")
	if is_on_floor() == false && velocity.y > 300:
		$AnimatedSprite.play("duck")
	velocity.y += 30
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2.UP)