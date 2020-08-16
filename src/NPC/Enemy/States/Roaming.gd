extends State

func physics_process(delta):
	var move = get_parent()
	move.physics_process(delta)
	if (owner.direction == owner.DIRECTION_RIGHT):
		move.velocity.x = move.speed
		owner.skin.sprite.flip_h = false
		owner.attack_trigger.cast_to.x = 40
	elif (owner.direction == owner.DIRECTION_LEFT):
		move.velocity.x = -move.speed
		owner.skin.sprite.flip_h = true
		owner.attack_trigger.cast_to.x = -40
	
	move.velocity.y += move.gravity

	move.velocity = owner.move_and_slide(move.velocity, owner.FLOOR_NORMAL)
	
	if owner.is_on_wall():
		owner.raycast.position.x *= -1
		move.flipDirection()
	
	if owner.raycast.is_colliding() == false:
		move.flipDirection()
		owner.raycast.position.x *= -1

func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	owner.skin.loop("run", true)


func exit() -> void:
	owner.skin.loop("run", false)
	var move: = get_parent()
	move.exit()


