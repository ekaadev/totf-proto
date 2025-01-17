extends Node

const MASTER_BUS = "Master"
const MUSIC_BUS = "Music"
const SFX_BUS = "SFX"

var master_volume: float = 1.0:
    set(value):
        master_volume = value
        _update_all_volumes()

var music_volume: float = 1.0:
    set(value):
        music_volume = value
        _update_bus_volume(MUSIC_BUS, value)

var sfx_volume: float = 1.0:
    set(value):
        sfx_volume = value
        _update_bus_volume(SFX_BUS, value)

func _ready() -> void:
    _ensure_buses_exist()
    load_settings()

# Ensure that the buses exist
func _ensure_buses_exist() -> void:
    if AudioServer.get_bus_index(MASTER_BUS) == -1:
        AudioServer.add_bus(0)
        AudioServer.set_bus_name(0, MASTER_BUS)
    
    if AudioServer.get_bus_index(MUSIC_BUS) == -1:
        AudioServer.add_bus(1)
        AudioServer.set_bus_name(1, MUSIC_BUS)
    
    if AudioServer.get_bus_index(SFX_BUS) == -1:
        AudioServer.add_bus(2)
        AudioServer.set_bus_name(2, SFX_BUS)

# Update the volume of a bus
func _update_bus_volume(bus_name: String, volume: float) -> void:
    var bus_idx = AudioServer.get_bus_index(bus_name)
    if bus_idx >= 0:
        var final_volume = volume * master_volume
        AudioServer.set_bus_volume_db(bus_idx, linear_to_db(final_volume))
        save_settings()

# Update all volumes (MASTER, MUSIC, SFX)
func _update_all_volumes() -> void:
    _update_bus_volume(MUSIC_BUS, music_volume)
    _update_bus_volume(SFX_BUS, sfx_volume)
    var master_idx = AudioServer.get_bus_index(MASTER_BUS)
    if master_idx >= 0:
        AudioServer.set_bus_volume_db(master_idx, linear_to_db(master_volume))
    save_settings()

# Save the audio settings to a config file
func save_settings() -> void:
    var config = ConfigFile.new()
    config.set_value("audio", "master_volume", master_volume)
    config.set_value("audio", "music_volume", music_volume)
    config.set_value("audio", "sfx_volume", sfx_volume)
    config.save("user://audio_settings.cfg")

# Load the audio settings from a config file
func load_settings() -> void:
    var config = ConfigFile.new()
    var err = config.load("user://audio_settings.cfg")
    if err == OK:
        master_volume = config.get_value("audio", "master_volume", 1.0)
        music_volume = config.get_value("audio", "music_volume", 1.0)
        sfx_volume = config.get_value("audio", "sfx_volume", 1.0)
    _update_all_volumes()