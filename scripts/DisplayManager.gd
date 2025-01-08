extends Node

signal settings_changed

enum WindowMode {
    WINDOWED,
    FULLSCREEN,
    BORDERLESS
}

var current_window_mode: WindowMode = WindowMode.WINDOWED:
    set(value):
        current_window_mode = value
        _apply_window_mode()
        save_settings()

var vsync_enabled: bool = true:
    set(value):
        vsync_enabled = value
        _apply_vsync()
        save_settings()

var current_resolution: Vector2i = Vector2i(1920, 1080):
    set(value):
        current_resolution = value
        _apply_resolution()
        save_settings()

func _ready() -> void:
    load_settings()

func _apply_window_mode() -> void:
    match current_window_mode:
        WindowMode.WINDOWED:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
        WindowMode.FULLSCREEN:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
        WindowMode.BORDERLESS:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
    emit_signal("settings_changed")

func _apply_vsync() -> void:
    if vsync_enabled:
        DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
    else:
        DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
    emit_signal("settings_changed")

func _apply_resolution() -> void:
    DisplayServer.window_set_size(current_resolution)
    emit_signal("settings_changed")

func save_settings() -> void:
    var config = ConfigFile.new()
    config.set_value("display", "window_mode", current_window_mode)
    config.set_value("display", "vsync", vsync_enabled)
    config.set_value("display", "resolution", current_resolution)
    config.save("user://display_settings.cfg")

func load_settings() -> void:
    var config = ConfigFile.new()
    var err = config.load("user://display_settings.cfg")
    if err == OK:
        current_window_mode = config.get_value("display", "window_mode", WindowMode.WINDOWED)
        vsync_enabled = config.get_value("display", "vsync", true)
        current_resolution = config.get_value("display", "resolution", Vector2i(1920, 1080))
        _apply_window_mode()
        _apply_vsync()
        _apply_resolution()