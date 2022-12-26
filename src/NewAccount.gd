extends Control

var path: String = "user://user_data.json"
var user_data: Dictionary = {
	
}


func _ready() -> void:
	$Back.connect("pressed", self, "on_back_pressed")
	$Signup.connect("pressed", self, "on_signup")
	#get_node("../Popup").show()
	#get_node("../Popup").connect("gui_input", get_node("../Popup"), "hide")
	get_node("../Popup/Exit").connect("pressed", self, "on_popup_close")
	load_data()


func on_signup() -> void:
	var username = $Username/LineEdit.text
	var password = $Password/LineEdit.text
	if password.empty() or username.empty():
		print("empty")
		get_node("../Popup/Message").text = "Password atau Username tidak boleh kosong!"
		get_node("../Popup").show()
		return
	if user_data.has(username):
		get_node("../Popup/Message").text = "Username sudah ada!"
		get_node("../Popup").show()
		return
	user_data[username] = password
	
	var save_data = File.new()
	get_node("../Popup/Message").text = "Buat akun berhasil!"
	save_data.open(path, File.WRITE)
	save_data.store_line(to_json(user_data))
	get_node("../Popup").show()


func load_data() -> void:
	var save_data = File.new()
	if not save_data.file_exists(path):
		return # Error! We don't have a save to load.
	save_data.open(path, File.READ)
	while save_data.get_position() < save_data.get_len():
		var node_data = parse_json(save_data.get_line())
		user_data = node_data
	save_data.close()


func on_popup_close() -> void:
	if get_node("../Popup/Message").text == "Buat akun berhasil!":
		get_node("../Popup").hide()
		hide()
		return
	get_node("../Popup").hide()


func on_back_pressed() -> void:
	hide()
	get_node("../Login").show()
