extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	preload("res://TitleScreen.tscn")
	yield(get_tree().create_timer(6), "timeout") # Replace with function body.
	get_tree().change_scene("res://TitleScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
