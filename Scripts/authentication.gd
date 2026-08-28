extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	get_tree().change_scene_to_file("res://Scenes/home_page.tscn")
	
	
	if Firebase.Auth.check_auth_file():
		$StateLabel.text = "Successfully logged in!"
	else:
		$StateLabel.text = "An error occurred. This could either be a mistake or that your account has been deleted."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sign_up_pressed() -> void:
	var email = $Email.text
	var password = $Password.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	$StateLabel.text = "Signing up..."

func _on_login_pressed() -> void:
	var email = $Email.text
	var password = $Password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$StateLabel.text = "Logging in..."
	
func on_login_succeeded(auth):
	print(auth)
	$StateLabel.text = "Successfully logged in!"
	Firebase.Auth.save_auth(auth)

func on_signup_succeeded(auth):
	print(auth)
	$StateLabel.text = "Successfully signed up!"
	Firebase.Auth.save_auth(auth)
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$StateLabel.text = "Login failed: %s" % message
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	$StateLabel.text = "Sign up failed: %s" % message
