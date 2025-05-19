extends Node2D

const speed = 150

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
	equip_weapon(1, Gun) 

func fire_weapon(slot_index: int):
	var weapon = equipped_weapons[slot_index]
	if weapon == null or weapon.type != "Ranged":
		return

	var bullet_scn = weapon.bullet_scene
	if bullet_scn == null:
		print("No bullet scene assigned to weapon.")
		return

	# Choose correct arm and fire point
	var arm = "left" if slot_index == 0 else "right"
	var fire_point = weapon_sprites[arm].get_node("FirePoint")

	var bullet = bullet_scn.instantiate()
	bullet.global_position = fire_point.global_position
	
	bullet.rotation = global_rotation
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	bullet.linear_velocity = direction * 600
	
	bullet.gravity_scale = 0
	get_tree().current_scene.add_child(bullet)
	

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	rotation = direction.angle() + PI/2
	if Input.is_action_pressed("ui_attack_left"):
		fire_weapon(0)
		play_attack_anim(1)
	else:
		play_attack_anim(3)
	if Input.is_action_pressed("ui_attack_right"):
		fire_weapon(1)
		play_attack_anim(2)
	else:
		play_attack_anim(4)
	
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		play_anim(1)
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		play_anim(1)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
		play_anim(1)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		play_anim(1)
	elif Input.is_action_pressed("ui_right"):
		play_anim(1)
	elif Input.is_action_pressed("ui_left"):
		play_anim(1)
	elif Input.is_action_pressed("ui_down"):
		play_anim(1)
	elif Input.is_action_pressed("ui_up"):
		play_anim(1)
	else:
		play_anim(0)
	
func play_anim(movement):
	var body = $AnimatedSprite2D

	if movement == 1:
		body.play("move")
	else:
		body.play("idle")

var held = false

func play_attack_anim(attack):
	var anim = $AnimatedSprite2D
	if attack == 1 and held == false:
		if equipped_weapons[0].weapon_name == "Gun":
			weapon_sprites["left"].play("move")
			await get_tree().create_timer(1).timeout
			weapon_sprites["left"].play("spun_up")
			held = true

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
