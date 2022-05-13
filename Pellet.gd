extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player_body = get_owner().get_node("FPController/PlayerBody/KinematicBody")
onready var pellet_sound = get_owner().get_node("Pellets/PelletSound")
onready var player_properties = get_owner().get_node("PlayerProperties")

signal pellet_eaten
# Called when the node enters the scene tree for the first time.

#func _ready():
	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PelletHitBox_body_entered(body):
	if body != player_body:
		return
	
	if self.visible == false:
		return
		
	if body == player_body and self.visible == true:
		self.visible = false
		$PelletHitBox/CollisionShape.disabled = true
		pellet_sound.play()
		player_properties.score += player_properties.pellet_value
		emit_signal("pellet_eaten")
		# Replace with function body.

func new_game():
	self.visible = true
	$PelletHitBox/CollisionShape.disabled = false
