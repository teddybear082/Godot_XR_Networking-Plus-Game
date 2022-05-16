extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	preload("res://Main.tscn")
#	yield(get_tree().create_timer(8), "timeout") # Replace with function body.
#	get_tree().change_scene("res://Main.tscn") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $FPController/LeftHandController.is_button_pressed(15) and $FPController/RightHandController.is_button_pressed(15):
		get_tree().change_scene("res://Main.tscn")
	if $FPController.transform.origin.y < -5:
		$FPController.transform.origin = Vector3(0,2,0)


func _on_StartButtonArea_area_entered(area):
	if area == $FPController/LeftHandController/Function_Pickup or area == $FPController/RightHandController/Function_Pickup:
		 get_tree().change_scene("res://Main.tscn")# Replace with function body.