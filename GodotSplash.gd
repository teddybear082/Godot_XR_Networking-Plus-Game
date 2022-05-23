extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var apiKey = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var f = File.new()
	f.open("res://swAPIKey.env", File.READ)
	self.apiKey = f.get_line()
	f.close()
	SilentWolf.configure({"api_key": self.apiKey, "game_id": "Pellet-Man", "game_version": "1.0.6","log_level": 1})
	preload("res://TitleScreen.tscn")
	yield(get_tree().create_timer(6), "timeout") # Replace with function body.
	get_tree().change_scene("res://TitleScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
