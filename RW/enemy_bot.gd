extends CharacterBody2D

func _ready():
	var anim = $AnimatedSprite2D
	
	anim.play("move")
	
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
