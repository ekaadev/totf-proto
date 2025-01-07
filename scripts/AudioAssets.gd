extends Node

var menu_music = preload("res://assets/music/bgm/Because I Will Protect You -Reload- - Persona 3 Reload Original Soundtrack.mp3")
var menu_cursor = preload("res://assets/music/sfx/cursor.wav")

@onready var music_player = AudioStreamPlayer.new()
@onready var sfx_player = AudioStreamPlayer.new()

func _ready() -> void:
    add_child(music_player)
    add_child(sfx_player)
    
    # Set bus
    music_player.bus = "Music"    
    sfx_player.bus = "SFX"
    
func play_music(music_res: AudioStream, volume: float) -> void:
    music_player.stream = music_res
    music_player.volume_db = volume
    music_player.play()

func play_sfx(sfx_res: AudioStream, volume: float) -> void:
    sfx_player.stream = sfx_res
    sfx_player.volume_db = volume
    sfx_player.play()

func stop_music(fade_duration: float = 1.0) -> void:
    var tween = create_tween()
    tween.tween_property(music_player, "volume_db", -80.0, fade_duration).set_ease(Tween.EASE_IN_OUT)
    await tween.finished
    music_player.stop()
    # music_player.volume_db = -60.0  # Reset volume for next play