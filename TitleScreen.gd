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
		$FPController.transform.origin = Vector3(3.8,31,-1.25)


func _on_StartButtonArea_area_entered(area):
	if area == $FPController/LeftHandController/Function_Pickup or area == $FPController/RightHandController/Function_Pickup:
		if area == $FPController/LeftHandController/Function_Pickup:
			$FPController/LeftHandController.set_rumble(.5) 
			yield(get_tree().create_timer(1), "timeout") 
			$FPController/LeftHandController.set_rumble(0) 
		if area == $FPController/RightHandController/Function_Pickup:
			$FPController/RightHandController.set_rumble(.5) 
			yield(get_tree().create_timer(1), "timeout") 
			$FPController/RightHandController.set_rumble(0) 
		get_tree().change_scene("res://Main.tscn")# Replace with function body.
