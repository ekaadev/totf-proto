extends Node

signal progress_changed(progress)
signal load_done

var _loaded_resource : PackedScene
var _scene_path : String
var _progress : Array = []

var use_sub_threads : bool = true

# load scene function
# - load the scene
# - load the loading screen
func load_scene(scene_path: String, load_path: String) -> void:
	var loading_screen = load(load_path)
	_scene_path = scene_path

	var new_loading_screen = loading_screen.instantiate()
	get_tree().get_root().add_child(new_loading_screen)

	self.progress_changed.connect(new_loading_screen._update_progress_bar)
	self.load_done.connect(new_loading_screen._start_outro_animation)

	await Signal(new_loading_screen, "loading_screen_has_full_coverage")

	start_load()

# start load function
func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(_scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

# process function
func _process(_delta: float) -> void:
	var load_status =  ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	match load_status:
		# THREAD_LOAD_INVALID_RESOURCE, THREAD FAILED
		0, 2: 
			set_process(false)
			return
		# THREAD_LOAD_IN_PROGRESS
		1:
			emit_signal("progress_changed", _progress[0])
		# THREAD_LOAD_COMPLETE
		3:
			_loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			emit_signal("progress_changed", 1.0)
			emit_signal("load_done")
			get_tree().change_scene_to_packed(_loaded_resource)
	