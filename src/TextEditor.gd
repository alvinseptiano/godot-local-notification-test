extends Control

var script_text: String


func _ready() -> void:
	for btn in $BTNS.get_children():
		btn.connect("pressed", self, "on_save_pressed", [btn.name.to_upper()])
	$FileDialog.connect("file_selected", self, "on_file_selected")
	$FileDialog.connect("dir_selected", self, "on_save_file")


func on_save_pressed(btn_name: String) -> void:
	print(btn_name)
	if btn_name == "SAVE":
		$FileDialog.mode =FileDialog.MODE_SAVE_FILE
	elif btn_name == "LOAD":
		$FileDialog.mode =FileDialog.MODE_OPEN_FILE
	script_text = $TextEdit.text
	$FileDialog.show()


func on_file_selected(path: String) -> void:
	var f = File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()
	f.close()


func on_save_file(path: String) -> void:
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
