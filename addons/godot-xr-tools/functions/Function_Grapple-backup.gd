tool
class_name Function_Grapple
extends MovementProvider

##
## Movement Provider for Grapple Movement
##
## @desc:
##     This script provide simple grapple based movement - "bat hook" style where the player moves directly to the grapple location.
##     This script works with the PlayerBody
##     attached to the players ARVROrigin.
##
##     The player may have multiple movement nodes attached to different
##     controllers to provide different types of movement.
##
##     The player can have a grapple node attached to each hand and the movement should not break.
##

## Movement provider order
export var order := 20

## Grapple speed - use to adjust how far player can go with grapple.  Lower setting will mean player may not reach targeted point.
## Higher speed may eventually make it hard for the player to stay in the world or on surfaces due to too much velocity.
export var grapple_speed := 1.5

##Grapple length - use to adjust maximum distance for possible grapple hooking.
export var grapple_length := 15.0

##Probably need to add export variables for line size, maybe line material at some point so dev does not need to make children editable to do this
##For now, right click on grapple node and make children editable to edit these facets.
export var rope_width = .02

# enum our buttons, should find a way to put this more central
enum Buttons {
	VR_BUTTON_BY = 1,
	VR_GRIP = 2,
	VR_BUTTON_3 = 3,
	VR_BUTTON_4 = 4,
	VR_BUTTON_5 = 5,
	VR_BUTTON_6 = 6,
	VR_BUTTON_AX = 7,
	VR_BUTTON_8 = 8,
	VR_BUTTON_9 = 9,
	VR_BUTTON_10 = 10,
	VR_BUTTON_11 = 11,
	VR_BUTTON_12 = 12,
	VR_BUTTON_13 = 13,
	VR_PAD = 14,
	VR_TRIGGER = 15
}

## Can Grapple flag - make sure we really want to use grapple.  Allows turning off situationally.
export var canGrapple := true

## Grapple button (triggers grappling movement).  Be sure this button does not conflict with other functions.
export (Buttons) var grapple_button_id = Buttons.VR_TRIGGER

# Get Controller node - consider way to universalize this if user wanted to attach this
# to a gun instead of player's hand.  Could consider variable to select controller instead.
onready var _controller : ARVRController = get_parent()
onready var player = get_parent().get_parent()

#Get Raycast node
onready var grapple_raycast : RayCast = $Grapple_RayCast

#Get Grapple Target Node 
onready var grapple_target = $Grapple_Target

#Hook related variables
var hook_point = Vector3(0,0,0)
var hooked = false 

#Get line creation nodes
onready var line_helper = $LineHelper
onready var line = $LineHelper/Line

#prevent weird glitches by having the hook "attach" too close to player
var min_hook_length = 1.5 * ARVRServer.world_scale


#set Grapple Length and Line Width
func _ready():
	
	if grapple_length < min_hook_length:
		grapple_length = min_hook_length
		
	grapple_raycast.cast_to = Vector3(0,0,-grapple_length)*ARVRServer.world_scale #Is WS necessary here?
	
	#deal with line
	line.radius = rope_width
	line.hide()

# Perform grapple movement
func physics_movement(delta: float, player_body: PlayerBody):
	var curr_transform = player_body.kinematic_node.global_transform #Just set for function, needs player body so needes to be here
	var line_length = 1.0 #just set line length variable for function, possibly move to global variable. Length here is arbitrary since will be adjusted every frame below.
	
	# Skip if the controller isn't active
	if !_controller.get_is_active():
		return
		
	#hide grapple target if there is no collision with any available surface
	if !grapple_raycast.is_colliding():
		grapple_target.visible = false
		
	# Detect grapple and show grapple target as long as there is a surface player could collide with
	if grapple_raycast.is_colliding():
		grapple_target.visible = true
		grapple_target.global_transform.origin  = grapple_raycast.get_collision_point()
		grapple_target.global_transform = grapple_target.global_transform.orthonormalized() #trying to add basis command
	
	#When a grapple is available and player presses the grapple button, latch on
	if canGrapple and _controller.is_button_pressed(grapple_button_id) and grapple_raycast.is_colliding() and hooked == false:
		curr_transform = player_body.kinematic_node.global_transform
		hook_point = grapple_raycast.get_collision_point()
		
		
		#grapple line creation to hook point
		line_helper.look_at(hook_point, Vector3.UP)
		line_length = (hook_point - curr_transform.origin).length()
		line.height = line_length
		line.translation.z = line_length / -2
		line.show()
		
		
		#move player with grapple motion and confirm hook
		
		player_body.velocity = player_body.move_and_slide(hook_point - curr_transform.origin) * grapple_speed #* ARVRServer.world_scale (Don't think I need WS here, needs more testing)
		hooked = true 
		
		
		# Report exclusive motion (to bypass gravity)
		return true 
		
	else: 
		#once player lets go of button, stop grappling
		if !_controller.is_button_pressed(grapple_button_id): 
			hooked = false
			line.hide()
		
		#If player continues to hold down grapple button even though hook already happened, keep line in hook spot
		if canGrapple and _controller.is_button_pressed(grapple_button_id) and hooked == true:
			line_helper.look_at(hook_point, Vector3.UP)
			line_length = (hook_point - curr_transform.origin).length()
			line.height = line_length
			line.translation.z = line_length / -2
			
		return 
	
	

# This method verifies the MovementProvider has a valid configuration.
func _get_configuration_warning():
	
	# Check the controller node
	
	var test_controller = get_parent()
	if !test_controller or !test_controller is ARVRController:
		return "Unable to find ARVR Controller node"

	# Call base class
	return ._get_configuration_warning()
