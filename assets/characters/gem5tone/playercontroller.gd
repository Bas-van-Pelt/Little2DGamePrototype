extends CharacterBody2D

@export var movement_speed : int = 175
@onready var sprite_2d = $AnimatedSprite2D
var idle_animation_counter : int = 0
var idle_animation_count : int = 2

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite_2d.animation == "idle":
		idle_animation_counter += 1
		if idle_animation_counter >= idle_animation_count:
			sprite_2d.play("idle_with_blink")
			idle_animation_counter = 0
	elif sprite_2d.animation == "idle_with_blink":
		sprite_2d.animation = "idle"
	else:
		idle_animation_counter = 0

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = input_direction * movement_speed
	move_and_slide()

	if input_direction != Vector2.ZERO:
		if abs(input_direction.x) > abs(input_direction.y):
			sprite_2d.animation = "walk_sidewards"
			sprite_2d.flip_h = input_direction.x < 0
		else:
			if input_direction.y > 0:
				sprite_2d.animation = "walk_forward"
			else:
				sprite_2d.animation = "walk_backwards"
			sprite_2d.flip_h = false
	else:
		if sprite_2d.animation != "idle_with_blink":
			sprite_2d.play("idle")
		sprite_2d.flip_h = false
