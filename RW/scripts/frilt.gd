extends CharacterBody2D

const speed = 100
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		current_dir = "45"
		play_anim(1)
		velocity.x = speed/2
		velocity.y = speed/-2
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		current_dir = "135"
		play_anim(1)
		velocity.x = speed/2
		velocity.y = speed/2
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		current_dir = "315"
		play_anim(1)
		velocity.x = speed/-2
		velocity.y = speed/-2
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		current_dir = "225"
		play_anim(1)
		velocity.x = speed/-2
		velocity.y = speed/2
	elif Input.is_action_pressed("ui_right"):
		current_dir = "90"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "270"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "180"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "0"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "0":
		anim.flip_h = false
		anim.play("back")
	if dir == "45":
		anim.flip_h = false
		anim.play("side-back")
	if dir == "90":
		anim.flip_h = false
		anim.play("side")
	if dir == "135":
		anim.flip_h = false
		anim.play("side-front")
	if dir == "180":
		anim.flip_h = false
		anim.play("front")
	if dir == "225":
		anim.flip_h = true
		anim.play("side-front")
	if dir == "270":
		anim.flip_h = true
		anim.play("side")
	if dir == "315":
		anim.flip_h = true
		anim.play("side-back")
