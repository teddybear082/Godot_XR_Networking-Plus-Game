extends Control


onready var player_properties = get_tree().get_root().find_node("PlayerProperties",true,false)
onready var wrist_text = $WristRect/WristText

var lives = 3
var score = 0
var level = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	player_properties.connect("player_data_changed",self,"handle_data_changed")
	wrist_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score) + "\nLevel: " + str(level))
		
func handle_data_changed(player_lives, player_score, player_level):
	print("Data updated")
	lives = player_lives
	score = player_score
	level = player_level
	wrist_text.set_text("Lives: " + str(lives) + "\nScore: " + str(score) + "\nLevel: " + str(level))
