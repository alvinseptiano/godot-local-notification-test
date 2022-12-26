extends Control

var path: String = "user://user_data.json"
var user_data: Dictionary


func _ready() -> void:
	$NewAccount.connect("pressed", self, "on_create_new_account")
	$Login.connect("pressed", self, "on_login")
	get_node("../Popup/Exit").connect("pressed", self, "on_close_popup")
	connect("visibility_changed", self, "load_data")


func on_create_new_account() -> void:
	get_parent().emit_signal("create_account")
	get_node("../NewAccount").show()


func on_login() -> void:
	load_data()
	var username = $Username/LineEdit.text
	var password = $Password/LineEdit.text
	if user_data.has(username):
		if user_data[username] == password:
			get_node("../OTP").show()
			get_node("../Popup/Message").text = "Login Berhasil!"
			#get_node("../Popup").show()
			return
		get_node("../Popup/Message").text = "Password yang dimasukan salah!"
		get_node("../Popup").show()
		return
	get_node("../Popup/Message").text = "Username tidak ada!"
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


func on_close_popup() -> void:
	if get_node("../Popup/Message").text == "Login Berhasil!":
		get_node("../Popup").hide()
		hide()
		return
	get_node("../Popup").hide()
	
