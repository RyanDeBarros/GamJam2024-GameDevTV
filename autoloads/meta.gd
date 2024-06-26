extends Node


const savefile := "user://progress.save"
const save_version := 1


func _ready() -> void:
	load_progress()
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		save_progress()
		get_tree().quit()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_progress()


func save_progress() -> void:
	var file := FileAccess.open(savefile, FileAccess.WRITE)
	if not file: return
	file.store_16(save_version)
	file.store_8(LevelManager.current_level)
	file.close()


func load_progress() -> void:
	var file := FileAccess.open(savefile, FileAccess.READ)
	if not file: return
	if file.get_16() != save_version: return
	LevelManager.current_level = file.get_8()
	file.close()
