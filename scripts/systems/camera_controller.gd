extends Camera2D

enum Mode { FOLLOW, FOLLOW_DELAY, FIXED, GRID_SNAPPING }

@export_category("General Settings")
@export var mode: Mode = Mode.FOLLOW
@export var target_node: Node2D

@export_category("System Status")
@export var is_active: bool = true
@export var enable_zoom: bool = true
@export var enable_smoothing: bool = true

@export_category("Follow Options")
@export var follow_smoothing: float = 5.0
@export var follow_offset: Vector2 = Vector2.ZERO
@export var follow_delay: float = 0.2

@export_category("Grid / Room Options")
@export var grid_size: Vector2 = Vector2(640, 360)
@export var grid_smoothing: float = 8.0

@export_category("Zoom Settings")
@export var zoom_speed: float = 10.0
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

var _target_zoom: float = 1.0

func _ready() -> void:
	make_current()
	if target_node:
		global_position = target_node.global_position
	_target_zoom = zoom.x

func _process(delta: float) -> void:
	if not is_active or not target_node:
		return

	match mode:
		Mode.FOLLOW:
			_process_follow(delta)
		Mode.FOLLOW_DELAY:
			_process_follow_delay(delta)
		Mode.GRID_SNAPPING:
			_process_grid_snapping(delta)
		Mode.FIXED:
			pass

	if enable_zoom:
		_process_zoom(delta)

func _process_follow(delta: float) -> void:
	var target_pos = target_node.global_position + follow_offset
	if enable_smoothing:
		global_position = global_position.lerp(target_pos, follow_smoothing * delta)
	else:
		global_position = target_pos

func _process_follow_delay(delta: float) -> void:
	var target_pos = target_node.global_position + follow_offset
	var weight = clamp(delta / follow_delay, 0.0, 1.0) if enable_smoothing else 1.0
	global_position = global_position.lerp(target_pos, weight)

func _process_grid_snapping(delta: float) -> void:
	var player_pos = target_node.global_position
	var grid_x = floor(player_pos.x / grid_size.x) * grid_size.x + (grid_size.x / 2)
	var grid_y = floor(player_pos.y / grid_size.y) * grid_size.y + (grid_size.y / 2)
	var target_grid_pos = Vector2(grid_x, grid_y)
	
	if enable_smoothing:
		global_position = global_position.lerp(target_grid_pos, grid_smoothing * delta)
	else:
		global_position = target_grid_pos

func _process_zoom(delta: float) -> void:
	var final_zoom = Vector2(_target_zoom, _target_zoom)
	if enable_smoothing:
		zoom = zoom.lerp(final_zoom, zoom_speed * delta)
	else:
		zoom = final_zoom

func _unhandled_input(event: InputEvent) -> void:
	if not is_active or not enable_zoom:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_target_zoom = clamp(_target_zoom + 0.1, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_target_zoom = clamp(_target_zoom - 0.1, min_zoom, max_zoom)
