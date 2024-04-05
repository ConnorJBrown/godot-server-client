extends HBoxContainer

class_name PlayerListItem

signal kick_pressed(id: int)

@export var player_name_label: Label
@export var kick_button: Button

var player_name: String
var show_kick_button: bool = true

func _ready():
	player_name_label.text = player_name
	kick_button.visible = show_kick_button

func _on_kick_button_pressed():
	kick_pressed.emit(int(player_name))
