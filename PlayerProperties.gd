extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
export var lives := 3
export var pellet_value := 100
export var ghost_value := 1000
export var fruit_value := 500
export var energizer_value := 200
signal game_over
# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if lives == 0:
		emit_signal("game_over")
		print("Game over!")
	
