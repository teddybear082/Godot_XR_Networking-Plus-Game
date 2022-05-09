extends Area


# Choose the pickable object that should be holstered, the sound to play when activating the holster, and the max number of holstered item instances

export(PackedScene) var holstered_object
export var max_holstered_item_count = 1

var holstered_item_count = 0
var holstered_object_instance = null

# Called when the node enters the scene tree for the first time.
func _ready():
#	print("Holstered object scene is detected as " + str(holstered_object))
	holstered_object_instance = holstered_object.instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass


#Code to drop holstered item

func _on_ShoulderGrabArea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#pass
	#if object entering area is not a pick-up equipped hand, ignore the object
	
	if area.name !="Function_Pickup":
		return
	
	#code for checking if hand has a holstered item and if so then putting away holstered item if person presses trigger while overlapped with area
	
	if area.name == "Function_Pickup":
		var controller = area.get_parent()
		if overlaps_area(area) and controller.is_button_pressed(area.pickup_button_id) and controller.is_button_pressed(area.action_button_id):
			if area.picked_up_object != null and area.picked_up_object == holstered_object_instance:
#				print("Holstered object away is " + str(area.picked_up_object))
				$ShoulderSound.play()
				var obj_to_destroy = area.picked_up_object
				area.drop_object()
				obj_to_destroy.queue_free()
				holstered_item_count -= 1
				return
	
#Code to obtain holstered item

func _on_ShoulderGrabArea_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	
	#if object entering area is not a pick-up equipped hand, ignore the object
	if area.name !="Function_Pickup":
		return
	
	
	
	if area.name == "Function_Pickup":
		var controller = area.get_parent()
		if controller.is_button_pressed(area.pickup_button_id):
			
			#code for checking if hand is empty and if so, giving holstered item as long as there aren't too many in the scene
			if area.picked_up_object == null:
				if holstered_item_count < max_holstered_item_count: 
					$ShoulderSound.play()
					holstered_object_instance = holstered_object.instance()
					var scene_root = self.owner 
					scene_root.add_child(holstered_object_instance)
					holstered_object_instance.global_transform = controller.global_transform
					holstered_object_instance.global_transform = holstered_object_instance.global_transform.orthonormalized()
					holstered_object_instance.input_ray_pickable = false
					#This space to insert code per holstered object to make it look right in the player's hand
					
					
					#now pick up object
					area._pick_up_object(holstered_object_instance)
					holstered_item_count += 1
#					print("Holstered object grabbed is " + str(holstered_object_instance))
					return
			
			#if hand is not empty, check if it contains the designated item for the holster, and if "holster" modifer button is still pressed.
			#if so, then return item to the holster and reduce the count of instances of item in the wild.
					
			if area.picked_up_object != null and area.picked_up_object == holstered_object_instance:		
				if controller.is_button_pressed(area.pickup_button_id) and controller.is_button_pressed(area.action_button_id):
			
#					print("Holstered object away is " + str(area.picked_up_object))
					$ShoulderSound.play()
					var obj_to_destroy = area.picked_up_object
					area.drop_object()
					obj_to_destroy.queue_free()
					holstered_item_count -= 1
					return
			return

