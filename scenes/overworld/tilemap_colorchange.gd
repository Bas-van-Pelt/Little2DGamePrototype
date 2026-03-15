extends Node2D

@onready var tilemap_layer = $"."

func fade_to_inverse(duration: float):
	var mat = tilemap_layer.material as ShaderMaterial
	if mat:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(mat, "shader_parameter/amount", 1.0, duration).from(0.0)
		tween.tween_method(RenderingServer.set_default_clear_color, Color.BLACK, Color.WHITE, duration)

func _ready() -> void:
	fade_to_inverse(30.0)
