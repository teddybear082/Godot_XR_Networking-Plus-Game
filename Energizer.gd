extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player_body = get_owner().get_node("FPController/PlayerBody/KinematicBody")
onready var energizer_sound = get_owner().get_node("Energizers/EnergizerSound")
onready var player_properties = get_owner().get_node("PlayerProperties")
signal energizer_eaten

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EnergizerHitBox_body_entered(body):
	if body != player_body:
		return
	
	if self.visible == false:
		return
		
	if body == player_body and self.visible == true:
		self.visible = false
		$EnergizerHitBox/CollisionShape.disabled = true
		emit_signal("energizer_eaten")
		energizer_sound.play()
		player_properties.score += player_properties.energizer_value # Replace with function body.
		$EnergizerTimer.start()
		get_tree().call_group("ghosts", "escape_mode")
		
func _on_EnergizerTimer_timeout():
	get_tree().call_group("ghosts", "attack_mode")# Replace with function body.
	energizer_sound.play()
		#	
