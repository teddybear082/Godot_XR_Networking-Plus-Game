extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player_properties = get_tree().get_root().find_node("PlayerProperties",true,false)
onready var game_info_text = $NewGameRect/GameInfoRect/GameInfoText

var lives = 3
var score = 0
signal new_game_button_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	player_properties.connect("player_data_changed",self,"handle_data_changed")
	game_info_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score))
		
func handle_data_changed(player_lives, player_score):
	print("Data updated")
	lives = player_lives
	score = player_score
	game_info_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	game_info_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score))



func _on_NewGameButton_pressed():
	player_properties.new_game() # Replace with function body.
