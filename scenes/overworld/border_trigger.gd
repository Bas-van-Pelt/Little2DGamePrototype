extends Area2D

@export var margin: int = 36

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		var shape = $CollisionShape2D.shape
		var size = shape.size
		var center = $CollisionShape2D.global_position
		
		# Bereken de randen
		var left_bound = center.x - (size.x / 2.0)
		var right_bound = center.x + (size.x / 2.0)
		var top_bound = center.y - (size.y / 2.0)
		var bottom_bound = center.y + (size.y / 2.0)

		var target_pos = body.global_position

		if body.global_position.x <= left_bound + 5:
			target_pos.x += (size.x - margin)
		elif body.global_position.x >= right_bound - 5:
			target_pos.x -= size.x - margin

		if body.global_position.y <= top_bound + 5:
			target_pos.y += size.y - margin
		elif body.global_position.y >= bottom_bound - 5:
			target_pos.y -= (size.y - margin)
		body.global_position = target_pos
