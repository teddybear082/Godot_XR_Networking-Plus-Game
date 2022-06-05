extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var last_score = 0
var last_lives = 3
var level = 1
var wrist_view = null
var view_update_throttle = 0
export var player_name = "Guest"
export var lives := 3
export var pellet_value := 100
export var ghost_value := 1000
export var fruit_value := 500
export var energizer_value := 200
onready var arvrorigin = get_owner().get_node("FPController")
onready var start_position = get_owner().get_node("PacManStart1")
onready var leaderboard_view = get_owner().get_node("LeaderboardViewport3D/Viewport")
onready var main_menu_view = get_owner().get_node("PacManMenuScreen/Viewport")
onready var virtual_keyboard_view = get_owner().get_node("Virtual_Keyboard/Viewport2Din3D/Viewport")
onready var controls_view = get_owner().get_node("ControlsViewport/Viewport")
onready var tv_view = get_owner().get_node("PickableTV/TestTelevision/Viewport")
onready var network_view = get_owner().get_node("XR-Tools-Networking/ViewportNetworkGateway/Viewport")
signal game_over
signal player_data_changed(new_lives, new_score, new_level)
# Called when the node enters the scene tree for the first time.

func _ready():
	score = 0 # Replace with function body.
	last_score = 0
	last_lives = lives
	wrist_view = arvrorigin.get_node("LeftHandController/LeftHand/WristHUDViewport/Viewport")
	wrist_view.set_update_mode(1)
	leaderboard_view.set_update_mode(1)
	main_menu_view.set_update_mode(1)
	virtual_keyboard_view.set_update_mode(1)
	controls_view.set_update_mode(1)
	tv_view.set_update_mode(1)
	network_view.set_update_mode(1)
	view_update_throttle = 0
# Called when the node enters the scene tree for the first time.

		
#func handle_data_changed(player_lives, player_score):
	#print("Data updated")
	#lives = player_lives
	#score = player_score
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#process to throttle viewport updates
	view_update_throttle+=1
	if view_update_throttle == 65:
		leaderboard_view.set_update_mode(1)
		main_menu_view.set_update_mode(1)
		virtual_keyboard_view.set_update_mode(1)
		controls_view.set_update_mode(1)
		tv_view.set_update_mode(1)
		network_view.set_update_mode(1)
		view_update_throttle = 0
	
	
	#if score goes up, update other elements that depend on player data
	if score > last_score:
		emit_signal("player_data_changed", lives, score, level)
		last_score = score
		wrist_view.set_update_mode(1)
	#if player loses life, update other elements that depend on player data	
	if lives < last_lives:
		emit_signal("player_data_changed", lives, score, level)
		last_lives = lives
		arvrorigin.transform.origin = start_position.global_transform.origin
		wrist_view.set_update_mode(1) 
	#player lost all lives, game over	
	if lives == 0:
		game_over() 
		
	#handle if player collected all pellets; rather than resetting score and lives, just put pellets back into place and reset ghost and player position	
	var pellet_count = -1
	var pellets = get_tree().get_nodes_in_group("pellets")
	for each_pellet in pellets:
		if each_pellet.visible == true:
			pellet_count+=1
	#print(str(pellet_count))
	if pellet_count == 0:
		get_tree().call_group("pellets", "new_game")
		get_tree().call_group("energizers", "new_game")
		reset_ghost_positions()
		level+=1
		emit_signal("player_data_changed", lives, score, level)
		wrist_view.set_update_mode(1)
		arvrorigin.transform.origin = start_position.global_transform.origin
		$PlayerNextLevelSound.play()
			
func new_game():
		print("New game is starting")
		
		#reset all stats
		lives = 3
		last_lives = 3
		score = 0
		last_score = 0
		level = 1
		#put player at the start of the game board
		arvrorigin.transform.origin = start_position.global_transform.origin
		
		#update score board
		emit_signal("player_data_changed", lives, score, level)
		wrist_view.set_update_mode(1)
		#reset ghost positions
		reset_ghost_positions()
			
		#put all pellets back where they should start
		get_tree().call_group("pellets", "new_game")
		get_tree().call_group("energizers", "new_game")

#handle game over
func game_over():
	emit_signal("game_over")
	print("Game over!")
	SilentWolf.Scores.persist_score(player_name, score)
	$PlayerGameOverSound.play()
	new_game()
	

#put each ghost back where they should start	
func reset_ghost_positions():
	var ghosts = get_tree().get_nodes_in_group("ghosts")
	for each_ghost in ghosts:
		each_ghost.global_transform.origin = each_ghost.ghost_starting_position
