extends Area2D

@export_category("Audio Setup")
@export var music_track : AudioStream

@onready var audio_player : AudioStreamPlayer2D = $IntroPlayer

func _ready():
	if music_track:
		audio_player.stream = music_track.duplicate()
		_set_loop(audio_player.stream, true)
	audio_player.volume_db = -80.0
	audio_player.play()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.is_in_group("player_character"):
		print("Player entered the zone, starting music")
		var tween = create_tween()
		tween.tween_property(audio_player, "volume_db", 0.0, 0.75)


func _on_body_exited(body):
	if body.is_in_group("player_character"):
		print("Player exits the zone: Fading music out")
		var tween = create_tween()
		tween.tween_property(audio_player, "volume_db", -80.0, 1.5)


func _set_loop(stream: AudioStream, loop_enabled: bool):
	if stream is AudioStreamWAV:
		stream.loop_mode = AudioStreamWAV.LOOP_FORWARD if loop_enabled else AudioStreamWAV.LOOP_DISABLED
	else:
		stream.loop = loop_enabled
