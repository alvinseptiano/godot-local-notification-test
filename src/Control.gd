extends Control

var kode_otp: int


func _ready() -> void:
	$Login/Login.connect("pressed", self, "on_button_pressed")


func create_otp_code() -> void:
	randomize()
	var rand_code = randi()
	#kode_otp = int(str(rand_code)[0][1][2][3])
	var rand_code_str = str(rand_code)
	kode_otp = int(rand_code_str.substr(0,4))


func on_button_pressed() -> void:
	push_notification()


func push_notification() -> void:
	create_otp_code()
	if Engine.has_singleton("LocalNotification"):
		var ln = Engine.get_singleton("LocalNotification")
		ln.showLocalNotification("kode otp : " + str(kode_otp), "KODE OTP", 2, 1)

