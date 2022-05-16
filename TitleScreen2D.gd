extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect/RichTextLabel.text = "START THE GAME"
	yield(get_tree().create_timer(10), "timeout")# Replace with function body.
	$TextureRect/RichTextLabel.text = "Can't figure it out???"
	yield(get_tree().create_timer(5), "timeout")
	$TextureRect/RichTextLabel.text = "Can't figure it out?? Press Y to fly...or A/X to grapple...or you could climb..."
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


