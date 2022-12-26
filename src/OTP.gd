extends Control


func _ready() -> void:
	$Confirm.connect("pressed", self, "on_confirm_pressed")


func on_confirm_pressed() -> void:
	if $LineEdit.text == str(get_parent().kode_otp):
		get_node("../Popup/Message").text = "Login Berhasil!"
		get_node("../Popup").show()
		get_node("../TextEditor").show()
		hide()
