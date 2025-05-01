extends Node2D
@export var weapon_data : Weapon
@export var bullet_scn: PackedScene
@export var bullet_speed: float
@export var bps: float
@export var bullet_damage: float

var fire_rate: float
var time_until_fire: float = 5.0
var time_to_despawn = 3.0

func _ready():
	if weapon_data:
		bullet_damage = weapon_data.damage
		
		bullet_speed = weapon_data.bullet_speed
		bps = weapon_data.bps
		fire_rate = 1.0 / bps
		$AnimatedSprite2D.sprite_frames = weapon_data.sprite


func _process(delta):
	if Input.is_action_just_pressed("ui_attack_left") and time_until_fire >= fire_rate:
		var bullet = bullet_scn.instantiate() as RigidBody2D
		
		
		# Spawn at gun position
		bullet.global_position = global_position
		
		# Use the gun's rotation directly
		var direction = Vector2.RIGHT.rotated(global_rotation)
		
		# Apply direction to bullet
		bullet.rotation = direction.angle()
		bullet.linear_velocity = direction * bullet_speed
		
		bullet.set("time_to_despawn", time_to_despawn)

		get_tree().root.add_child(bullet)
		time_until_fire = 0.0
	else:
		time_until_fire +=delta
