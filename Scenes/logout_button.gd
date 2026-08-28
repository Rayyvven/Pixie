extends TextureButton
@onready var logout_confirm: ConfirmationDialog = $LogoutConfirm


func _on_pressed() -> void:
	logout_confirm.visible = true

func _on_logout_confirm_confirmed() -> void:
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://authentication.tscn")
