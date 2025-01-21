extends Node

# Audio Assets for the game
# Global Audio Aseets which mean can play in different scenes
# include play music between transition

var menu_music = preload("res://assets/music/bgm/MAIN_MENU_BGM.wav")
var menu_cursor = preload("res://assets/music/sfx/SFX_UI_FOCUS.wav")
var menu_selected = preload("res://assets/music/sfx/SFX_UI_SELECTED.wav")
var menu_cancel = preload("res://assets/music/sfx/SFX_UI_CANCEL.wav")
var green_garden_music = preload("res://assets/music/bgm/GREEN_GARDEN_BGM.wav")
var blood_forest_music = preload("res://assets/music/bgm/BATTLE_BFD_BGM.wav")

@onready var music_player = AudioStreamPlayer.new()
@onready var sfx_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(music_player)
	add_child(sfx_player)
	
	# Set bus
	music_player.bus = "Music"    
	sfx_player.bus = "SFX"
	
# Play music
func play_music(music_res: AudioStream, volume: float) -> void:
	music_player.stream = music_res
	music_player.volume_db = volume
	music_player.play()

# Play sfx
func play_sfx(sfx_res: AudioStream, volume: float) -> void:
	sfx_player.stream = sfx_res
	sfx_player.volume_db = volume
	sfx_player.play()

# Stop music
func stop_music(fade_duration: float = 1.0) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -80.0, fade_duration).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	music_player.stop()
