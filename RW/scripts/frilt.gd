extends CharacterBody2D

const SPEED = 100
var aim_angle = 0.0
var mouse_lock_radius = 300
# Weapons
@export var equipped_weapons: Array[Weapon] = [null, null,null]  #Left, Right

@onready var weapon_sprites = {
	"left": $LeftArm,
	"right": $RightArm,
}

func _ready():
	# Example of equipping weapons
	var Gun = preload("res://weapons/Gun.tres")
	var Knife = preload("res://weapons/Knife.tres")
	
	#Hide mouse on start
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	

	equip_weapon(0, Gun) 
	equip_weapon(1, Knife) 


func _physics_process(delta):
	player_movement(delta)
	
func _process(delta):
	update_aim_direction()
	var centre = get_viewport_rect().size / 2
	var mouse_pos = get_viewport().get_mouse_position() / 2
	
	var to_mouse = mouse_pos - centre
	
	

func player_movement(delta):
	var input_vector = Input.get_vector("move_backward", "move_forward", "move_left", "move_right")
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		var move_direction = input_vector.rotated(aim_angle)
		velocity = move_direction * SPEED
		move_and_slide()
		play_body_anim(1)
	else:
		velocity = Vector2.ZERO
		play_body_anim(0)
	
	
	rotation = aim_angle + PI/2
	
func update_aim_direction():
	var viewport_center = get_viewport_rect().size / 2
	var mouse_on_screen = get_viewport().get_mouse_position()
	var to_mouse = mouse_on_screen - viewport_center
	aim_angle = to_mouse.angle()



func play_body_anim(movement):
	var anim = $AnimatedSprite2D

	if movement == 1:
		weapon_sprites["left"].play("move")
		weapon_sprites["right"].play("move")
		anim.play("move")
	else:
		weapon_sprites["left"].play("idle")
		weapon_sprites["right"].play("idle")
		anim.play("idle")

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
