extends CharacterBody2D

const speed = 150

func _ready():
	$Wheels.play("idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	
	
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		play_anim(1)
		rotation = 0.25 * PI
		velocity.x = speed*0.7
		velocity.y = speed*-0.7
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		play_anim(1)
		rotation = PI/2 + 0.25 * PI
		velocity.x = speed*0.7
		velocity.y = speed*0.7
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		play_anim(1)
		rotation = -0.25 * PI
		velocity.x = speed*-0.7
		velocity.y = speed*-0.7
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		rotation = -PI/2 + -0.25*PI
		play_anim(1)
		velocity.x = speed*-0.7
		velocity.y = speed*0.7
	elif Input.is_action_pressed("ui_right"):
		rotation = PI/2
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		rotation = -PI/2
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		rotation =PI
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		rotation = 0
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var body = $Wheels

	if movement == 1:
		body.play("move")
	else:
		body.stop()
