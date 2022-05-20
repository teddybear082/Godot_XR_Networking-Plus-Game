extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var jump_assignment = $ControllerTexture/JumpOptionButton
onready var left_grapple_assignment = $ControllerTexture/LeftGrappleOptionButton
onready var right_grapple_assignment = $ControllerTexture/RightGrappleOptionButton
onready var bullet_assignment = $ControllerTexture/BulletOptionButton
onready var movement_assignment = $ControllerTexture/MovementOptionButton
onready var hand_option_assignment = $ControllerTexture/HandOptionButton
onready var smooth_turn_assignment = $ControllerTexture/SmoothTurnCheckButton
onready var sprint_assignment = $ControllerTexture/SprintOptionButton
onready var left_holster_assignment = $ControllerTexture/LHolsterOptionButton
onready var right_holster_assignment = $ControllerTexture/RHolsterOptionButton
onready var left_controller = get_tree().get_root().find_node("LeftHandController",true,false)
onready var right_controller = get_tree().get_root().find_node("RightHandController",true,false)
var l_grapple_node = null
var r_grapple_node = null
var l_jump_node = null
var r_jump_node = null
var l_turn_node = null
var r_turn_node = null
var l_teleport_node = null
var r_teleport_node = null
var l_direct_move_node = null
var r_direct_move_node = null
var l_bullet_time_node = null
var r_bullet_time_node = null
var l_holster_button = null
var r_holster_button = null
enum Buttons {
	VR_BUTTON_BY = 1,
	VR_BUTTON_AX = 7,
	VR_PAD = 14,
	VR_TRIGGER = 15
}
var left_buttons_list = ["L B/Y", "L A/X", "L STICK CLICK", "L Trigger"]
var right_buttons_list = ["R B/Y", "R A/X", "R STICK CLICK", "R Trigger"]
var hand_options_list = ["Left Hand", "Right Hand"]
var movement_options_list = ["Smooth", "Teleport Trigger", "Teleport A/X", "Teleport B/Y", "Teleport Stick Click"]

var movement_hand_selected = "left"

signal move_hand_changed(hand)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Set all of the nodes that may be assigned
	l_grapple_node = left_controller.get_node("Function_Grapple")
	r_grapple_node = right_controller.get_node("Function_Grapple")
	l_jump_node = left_controller.get_node("Function_Jump_movement")
	r_jump_node = right_controller.get_node("Function_Jump_movement")
	l_turn_node = left_controller.get_node("Function_Direct_movement_turn_only")
	r_turn_node = right_controller.get_node("Function_Direct_movement_turn_only")
	l_teleport_node = load("res://addons/godot-xr-tools/functions/Function_Teleport.tscn").instance()
	r_teleport_node = load("res://addons/godot-xr-tools/functions/Function_Teleport.tscn").instance()
	l_direct_move_node = left_controller.get_node("Function_Direct_movement")
	r_direct_move_node = right_controller.get_node("Function_Direct_movement")
	l_bullet_time_node = left_controller.get_node("Function_BulletTime_movement")
	r_bullet_time_node = right_controller.get_node("Function_BulletTime_movement")
	
	
	#generate all of the options menus for the options button
	generate_selection(jump_assignment, left_buttons_list)
	generate_selection(jump_assignment, right_buttons_list)
	generate_selection(left_grapple_assignment, left_buttons_list)
	generate_selection(right_grapple_assignment, right_buttons_list)
	generate_selection(bullet_assignment, left_buttons_list)
	generate_selection(bullet_assignment, right_buttons_list)
	generate_selection(movement_assignment, movement_options_list)
	generate_selection(hand_option_assignment, hand_options_list)
	generate_selection(left_holster_assignment, left_buttons_list)
	generate_selection(right_holster_assignment, right_buttons_list)
	if movement_hand_selected == "left":
		generate_selection(sprint_assignment, left_buttons_list)
	if movement_hand_selected == "right":
		generate_selection(sprint_assignment, right_buttons_list)
	
	#assign the default controls
	hand_option_assignment.selected = 0
	jump_assignment.selected = 6
	left_grapple_assignment.selected = 1
	right_grapple_assignment.selected = 1
	bullet_assignment.selected = 4
	movement_assignment.selected = 0
	smooth_turn_assignment = false
	sprint_assignment.selected = 2
	left_holster_assignment.selected = 3
	right_holster_assignment.selected = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
	
func generate_selection(button, items):
	var ui_node = button
	
	for item in items:
		ui_node.add_item(item)

	
	
func _on_JumpOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15
	if index == 4:
		button_assignment = 1
	if index == 5:
		button_assignment =  7
	if index == 6:
		button_assignment = 14
	if index == 7:
		button_assignment = 15
	if index < 4:
		l_jump_node.enabled = true
		l_jump_node.jump_button_id = button_assignment
		r_jump_node.enabled = false
	if index >= 4:
		r_jump_node.enabled = true
		r_jump_node.jump_button_id = button_assignment
		l_jump_node.enabled = false
		
		
func _on_SmoothTurnCheckButton_toggled(button_pressed):
	if l_turn_node.smooth_rotation == true:
		l_turn_node.smooth_rotation = false
	else:
		l_turn_node.smooth_rotation = true 

	if r_turn_node.smooth_rotation == true:
		r_turn_node.smooth_rotation = false
	else:
		r_turn_node.smooth_rotation = true 
		
		
func _on_MovementOptionButton_item_selected(index):
	var button_assignment = null
	if movement_hand_selected  == "left":
		if index == 0:
			r_direct_move_node.enabled = false
			l_direct_move_node.enabled = true
			r_turn_node.enabled = true
			l_turn_node.enabled = false
			if left_controller.has_node("Function_Teleport"):
				left_controller.get_node("Function_Teleport").enabled = false
			if right_controller.has_node("Function_Teleport"):
				right_controller.get_node("Function_Teleport").enabled = false
		if index > 0:
			l_direct_move_node.enabled = false
			r_direct_move_node.enabled = false
			r_turn_node.enabled = true
			l_turn_node.enabled = false
			if left_controller.has_node("Function_Teleport") == false:
				left_controller.add_child(l_teleport_node)
			if right_controller.has_node("Function_Teleport"):
				right_controller.get_node("Function_Teleport").enabled = false
			l_teleport_node.enabled = true
		if index == 1:
			l_teleport_node.teleport_button = 15
		if index == 2:
			l_teleport_node.teleport_button = 7
		if index == 3:
			l_teleport_node.teleport_button = 1
		if index == 4:
			l_teleport_node.teleport_button = 14
		
	if movement_hand_selected == "right": # Replace with function body.
		if index == 0:
			l_direct_move_node.enabled = false
			r_direct_move_node.enabled = true
			l_turn_node.enabled = true
			r_turn_node.enabled = false
			if left_controller.has_node("Function_Teleport"):
				left_controller.get_node("Function_Teleport").enabled = false
			if right_controller.has_node("Function_Teleport"):
				right_controller.get_node("Function_Teleport").enabled = false
		if index > 0:
			l_direct_move_node.enabled = false
			r_direct_move_node.enabled = false
			r_turn_node.enabled = false
			l_turn_node.enabled = true
			if right_controller.has_node("Function_Teleport") == false:
				right_controller.add_child(r_teleport_node)
			if left_controller.has_node("Function_Teleport"):
				left_controller.get_node("Function_Teleport").enabled = false
			r_teleport_node.enabled = true
		if index == 1:
			r_teleport_node.teleport_button = 15
		if index == 2:
			r_teleport_node.teleport_button = 7
		if index == 3:
			r_teleport_node.teleport_button = 1
		if index == 4:
			r_teleport_node.teleport_button = 14

func _on_HandOptionButton_item_selected(index):
	if index == 0:
		movement_hand_selected = "left"
		emit_signal("move_hand_changed", "left")
	if index == 1: # Replace with function body.
		movement_hand_selected = "right"
		emit_signal("move_hand_changed", "right")
		
		
func _on_LeftGrappleOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15 # Replace with function body.
	l_grapple_node.grapple_button_id = button_assignment

func _on_BulletOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15
	if index == 4:
		button_assignment = 1
	if index == 5:
		button_assignment =  7
	if index == 6:
		button_assignment = 14
	if index == 7:
		button_assignment = 15
	if index < 4:
		l_bullet_time_node.enabled = true
		l_bullet_time_node.bullet_time_button_id = button_assignment
		r_bullet_time_node.enabled = false
	if index >= 4:
		r_bullet_time_node.enabled = true
		r_bullet_time_node.bullet_time_button_id = button_assignment
		l_bullet_time_node.enabled = false
		 # Replace with function body.


func _on_RightGrappleOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15 # Replace with function body.
	r_grapple_node.grapple_button_id = button_assignment# Replace with function body.


func _on_LHolsterOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15 
	
	left_controller.get_node("Function_Pickup").action_button_id = button_assignment# Replace with function body.


func _on_RHolsterOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15 
	
	right_controller.get_node("Function_Pickup").action_button_id = button_assignment# Replace with function body.


func _on_SprintOptionButton_item_selected(index):
	var button_assignment = null
	
	if index == 0:
		button_assignment = 1
	if index == 1:
		button_assignment = 7
	if index == 2:
		button_assignment = 14
	if index == 3:
		button_assignment = 15
	
	l_direct_move_node.sprint_button_id = button_assignment
	r_direct_move_node.sprint_button_id = button_assignment
		 # Replace with function body.pass # Replace with function body.


func _on_Control_move_hand_changed(hand):
	movement_hand_selected = hand
	if movement_hand_selected == "left":
		sprint_assignment.clear()
		generate_selection(sprint_assignment, left_buttons_list)
	if movement_hand_selected == "right":
		sprint_assignment.clear()
		generate_selection(sprint_assignment, right_buttons_list)
	_on_MovementOptionButton_item_selected(movement_assignment.selected)# Replace with function body.
