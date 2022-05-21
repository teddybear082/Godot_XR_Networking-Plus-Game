extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({"api_key": "fOJ6gFZ8dP2p2whqdgiFp5cUO1dO11zP11QP27AM", "game_id": "Pellet-Man", "game_version": "1.0.6","log_level": 1})
	preload("res://TitleScreen.tscn")
	yield(get_tree().create_timer(6), "timeout") # Replace with function body.
	get_tree().change_scene("res://TitleScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
