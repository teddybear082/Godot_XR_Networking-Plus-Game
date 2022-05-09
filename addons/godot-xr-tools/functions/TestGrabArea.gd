extends Area


# Choose the pickable object that should be holstered, the sound to play when activating the holster, and the max number of holstered item instances

export(PackedScene) var holstered_object

## Pickup function for the left hand
export (NodePath) var left_pickup = null

## Pickup function for the right hand
export (NodePath) var right_pickup = null

export var max_holstered_item_count = 1


var holstered_item_count = 0
var holstered_object_instance = null
var left_controller = null
var right_controller = null
var _left_pickup_node : Function_Pickup = null
var _right_pickup_node : Function_Pickup = null
var left_controller_button_states = [0,0]
var right_controller_button_states = [0,0]
signal holstering
signal unholstering

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Holstered object scene is detected as " + str(holstered_object))
	holstered_object_instance = holstered_object.instance()
	_left_pickup_node = get_node(left_pickup)
	_right_pickup_node = get_node(right_pickup)
	left_controller = _left_pickup_node.get_parent()
	right_controller = _right_pickup_node.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#ignore if neither hand is overlapping
	if !overlaps_area(_left_pickup_node) and !overlaps_area(_right_pickup_node):
		return
	
	 
	if overlaps_area(_left_pickup_node):
		#print("overlap detect")
		if left_button_pressed(left_controller, _left_pickup_node.action_button_id):
			if _left_pickup_node.picked_up_object != null: #check if player has some kind of object
				if _left_pickup_node.picked_up_object == holstered_object_instance:				#if player has some kind of object, check if it is a holstered object or some other pickable
					put_away_object(_left_pickup_node, _left_pickup_node.picked_up_object) #function that puts away object because it is a holstered item and player has pressed the button in the holster area, passes hand to the function
				else: #player has object, but its not our holstered object, so we should ignore it.
					return
			
			else: #player does not have an object and is pressing the action button so we can give the player the object
				if holstered_item_count < max_holstered_item_count:  #make sure max item count not exceeded before giving new item
					give_object(_left_pickup_node) #function that gives player object, passes hand to the function
				return
				
		
		
	if overlaps_area(_right_pickup_node): #was elif
		#print("overlap detect")
		
		if right_button_pressed(right_controller, _right_pickup_node.action_button_id):
			if _right_pickup_node.picked_up_object != null: #check if player has some kind of object
				if _right_pickup_node.picked_up_object == holstered_object_instance:				#if player has some kind of object, check if it is a holstered object or some other pickable
					put_away_object(_right_pickup_node, _right_pickup_node.picked_up_object) #function that puts away object because it is a holstered item and player has pressed the button in the holster area, passes hand to the function
				else: #player has object, but its not our holstered object, so we should ignore it.
					return
			
			else: #player does not have an object and is pressing the action button so we can give the player the object
				if holstered_item_count < max_holstered_item_count:  #make sure max item count not exceeded before giving new item
					give_object(_right_pickup_node) #function that gives player object, passes hand to the function
				return
		
	


#Code to holster item
func put_away_object(pickup_hand, item):
	#print("Holstering")
	emit_signal("holstering")
	$HolsterSound.play()
	var obj_to_destroy = item
	pickup_hand.drop_object()
	obj_to_destroy.queue_free()
	holstered_item_count -= 1
	return

#Code to obtain holstered item
func give_object(pickup_hand):
	#print("Getting item from holster")
	emit_signal("unholstering")
	$HolsterSound.play()
	holstered_object_instance = holstered_object.instance()
	var scene_root = self.owner 
	scene_root.add_child(holstered_object_instance)
	holstered_object_instance.global_transform = pickup_hand.get_parent().global_transform
	holstered_object_instance.global_transform = holstered_object_instance.global_transform.orthonormalized()
	
	pickup_hand._pick_up_object(holstered_object_instance)
	holstered_item_count += 1
	#print("Holstered object grabbed is " + str(holstered_object_instance))
	return


func _on_TestGrabArea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass
	

func _on_TestGrabArea_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass


#testing stumpynub's button input method to eliminate multi-inputs
func left_button_pressed(controller, b):
	if controller.is_button_pressed(b) and !left_controller_button_states.has(b):
		left_controller_button_states.append(b)
		return true
	if not controller.is_button_pressed(b) and left_controller_button_states.has(b):
		left_controller_button_states.erase(b)
	
	return false	
	
func right_button_pressed(controller, b):
	if controller.is_button_pressed(b) and !right_controller_button_states.has(b):
		right_controller_button_states.append(b)
		return true
	if not controller.is_button_pressed(b) and right_controller_button_states.has(b):
		right_controller_button_states.erase(b)
	
	return false	
