extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player_properties = get_tree().get_root().find_node("PlayerProperties",true,false)
onready var game_info_text = $NewGameRect/GameInfoRect/GameInfoText
onready var player_turn = get_tree().get_root().find_node("Function_Direct_movement_turn_only",true,false)

var lives = 3
var score = 0
var level = 1

signal new_game_button_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	player_properties.connect("player_data_changed",self,"handle_data_changed")
	game_info_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score) + "\nLevel: " + str(level))
		
func handle_data_changed(player_lives, player_score, player_level):
	#print("Data updated")
	lives = player_lives
	score = player_score
	level = player_level
	game_info_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score) + "\nLevel: " + str(level))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	game_info_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score))



func _on_NewGameButton_pressed():
	player_properties.new_game() # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit() # Replace with function body.



