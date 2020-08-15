extends State

func _physics_process(delta):
	var move = get_parent()
	if (owner.direction == owner.DIRECTION_RIGHT):
		move.velocity.x = move.speed
		owner.sprite.flip_h = false
	elif (owner.direction == owner.DIRECTION_LEFT):
		move.velocity.x = -move.speed
		owner.sprite.flip_h = true
	
	owner.sprite.play("run")
	move.velocity.y += move.gravity

	move.velocity = owner.move_and_slide(move.velocity, owner.FLOOR_NORMAL)
	
	if owner.is_on_wall():
		owner.raycast.position.x *= -1
		if (owner.direction == owner.DIRECTION_RIGHT):
			owner.direction = owner.DIRECTION_LEFT
		elif (owner.direction == owner.DIRECTION_LEFT):
			owner.direction = owner.DIRECTION_RIGHT
	
	if owner.raycast.is_colliding() == false:
		flipDirection()
		owner.raycast.position.x *= -1

func flipDirection() -> void:
	if (owner.direction == owner.DIRECTION_RIGHT):
		owner.direction = owner.DIRECTION_LEFT
	elif (owner.direction == owner.DIRECTION_LEFT):
		owner.direction = owner.DIRECTION_RIGHT
