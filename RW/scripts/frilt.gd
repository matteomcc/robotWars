extends CharacterBody2D

const SPEED = 100

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var mouse_pos = get_global_mouse_position()  
	var direction = (mouse_pos - global_position).normalized() 

	if global_position.distance_to(mouse_pos) > 5: 
		velocity = direction * SPEED
		move_and_slide()

		rotation = direction.angle() + PI/2

		play_anim(1)  
	else:
		velocity = Vector2.ZERO
		play_anim(0)  

func play_anim(movement):
	var anim = $AnimatedSprite2D

	if movement == 1:
		anim.play("move")  
	else:
		anim.play("idle")  
		
