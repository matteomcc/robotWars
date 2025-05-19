extends CharacterBody2D
const speed = 150


func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):

	
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		velocity.x = speed*0.7
		velocity.y = speed*-0.7
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		velocity.x = speed*0.7
		velocity.y = speed*0.7
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		velocity.x = speed*-0.7
		velocity.y = speed*-0.7
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		velocity.x = speed*-0.7
		velocity.y = speed*0.7
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -speed
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
