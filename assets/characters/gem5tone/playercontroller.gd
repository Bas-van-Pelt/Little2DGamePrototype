extends CharacterBody2D

@export var movement_speed : int = 175
@onready var sprite_2d = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	#animations
	if (velocity.y > 1):
		sprite_2d.animation = "walk_forward"
	elif (velocity.y < -1):
		sprite_2d.animation = "walk_backwards"
	elif (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "walk_sidewards"
	else:
		sprite_2d.animation = "idle"
	# Handle jump.
	var input_direction = Vector2(
		Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left"),
		Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")
	)
	#update velocity
	velocity = input_direction * movement_speed
	
	#mirror sprite
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
	#use move and slide function
	move_and_slide()
