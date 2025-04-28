extends CharacterBody2D

const SPEED = 100

# Weapons
@export var equipped_weapons: Array[Weapon] = [null, null,null]  #Left, Right

@onready var weapon_sprites = {
	"left": $LeftArm,
	"right": $RightArm,
	"thirdLeg": $test
}

func _ready():
	# Example of equipping weapons
	var Gun = preload("res://weapons/Gun.tres")
	var Knife = preload("res://weapons/Knife.tres")

	equip_weapon(0, Gun) 
	equip_weapon(1, Knife) 
	equip_weapon(2, Knife) 


func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()

	if global_position.distance_to(mouse_pos) > 5:
		velocity = direction * SPEED
		move_and_slide()

		rotation = direction.angle() + PI/2

		play_body_anim(1)  # moving
	else:
		velocity = Vector2.ZERO
		play_body_anim(0)  # idle

func play_body_anim(movement):
	var anim = $AnimatedSprite2D

	if movement == 1:
		weapon_sprites["left"].play("move")
		weapon_sprites["right"].play("move")
		weapon_sprites["thirdLeg"].play("move")
		anim.play("move")
	else:
		weapon_sprites["left"].play("idle")
		weapon_sprites["right"].play("idle")
		weapon_sprites["thirdLeg"].play("idle")
		anim.play("idle")

func equip_weapon(slot_index: int, weapon: Weapon):
	if slot_index >= 0 and slot_index < equipped_weapons.size():
		equipped_weapons[slot_index] = weapon

		match slot_index:
			0: setup_weapon_sprite(weapon_sprites["left"], weapon)
			1: setup_weapon_sprite(weapon_sprites["right"], weapon)
			2: setup_weapon_sprite(weapon_sprites["thirdLeg"], weapon)

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
