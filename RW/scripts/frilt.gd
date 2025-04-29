extends CharacterBody2D

const speed = 100

# Weapons
@export var equipped_weapons: Array[Weapon] = [null, null]  #Left, Right

@onready var weapon_sprites = {
	"left": $LeftArm,
	"right": $RightArm,
}

func _ready():
	# Example of equipping weapons
	var Gun = preload("res://weapons/Gun.tres")
	var Knife = preload("res://weapons/Knife.tres")

	equip_weapon(0, Gun) 
	equip_weapon(1, Knife) 


func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	rotation = direction.angle() + PI/2
	
	if Input.is_action_pressed("ui_attack_left"):
		play_attack_anim(1)
	else:
		play_attack_anim(3)
	if Input.is_action_pressed("ui_attack_right"):
		play_attack_anim(2)
	else:
		play_attack_anim(4)
	
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		play_anim(1)
		velocity.x = speed/2
		velocity.y = speed/-2
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		play_anim(1)
		velocity.x = speed/2
		velocity.y = speed/2
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		play_anim(1)
		velocity.x = speed/-2
		velocity.y = speed/-2
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		play_anim(1)
		velocity.x = speed/-2
		velocity.y = speed/2
	elif Input.is_action_pressed("ui_right"):
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var anim = $AnimatedSprite2D

	if movement == 1:
		anim.play("move")
	else:
		anim.play("idle")

func play_attack_anim(attack):
	var anim = $AnimatedSprite2D
	
	if attack == 1:
		weapon_sprites["left"].play("move")
	elif attack == 3:
		weapon_sprites["left"].play("idle")
	if attack == 2:
		weapon_sprites["right"].play("move")
	elif attack == 4:
		weapon_sprites["right"].play("idle")

func equip_weapon(slot_index: int, weapon: Weapon):
	if slot_index >= 0 and slot_index < equipped_weapons.size():
		equipped_weapons[slot_index] = weapon

		match slot_index:
			0: setup_weapon_sprite(weapon_sprites["left"], weapon)
			1: setup_weapon_sprite(weapon_sprites["right"], weapon)

	else:
		print("Invalid slot index: ", slot_index)

func setup_weapon_sprite(sprite: AnimatedSprite2D, weapon: Weapon):
	print("--- setup_weapon_sprite ---")
	print("Weapon: ", weapon)
	print("Weapon.frames: ", weapon.sprite)
	print("Sprite: ", sprite)
	if weapon != null:
		sprite.frames = weapon.sprite
		sprite.play("idle")  # Start idle animation
	else:
		sprite.frames = null
