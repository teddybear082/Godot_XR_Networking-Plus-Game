extends KinematicBody



var path = []
var path_node = 0
var speed = 5
var ghost_starting_position = Vector3(0,0,0)
var escape_material = null 
var normal_material = null
export var escape = false

onready var ghost = self
onready var target = get_owner().get_node("ARVROrigin/PlayerBody/KinematicBody")
onready var nav = get_owner().get_node("Navigation")
onready var player_properties = get_owner().get_node("PlayerProperties")

# Called when the node enters the scene tree for the first time.
func _ready():
	ghost_starting_position = self.global_transform.origin
	normal_material = $Ghost/Icosphere001.get_active_material(0)
	escape_material = load("res://escapeenemymaterial.tres")  
	
func _physics_process(delta):
	if path_node < path.size():
		var direction = (path[path_node]) - ghost.global_transform.origin
		#print(str(path[path_node]))
		#print("Distance to next path node is " +str(direction.length()))
		if direction.length() < 0.5:
			path_node+=1
		else:
			ghost.look_at(target.translation, Vector3.UP)
			ghost.move_and_slide(direction.normalized()*speed, Vector3.UP)
	#print(str(ghost.global_transform.origin))
	
		
	
func move_to(target_pos):
	path = nav.get_simple_path(ghost.global_transform.origin, target_pos)
	path_node = 0	


func _on_Ghost4Timer_timeout():
	if escape == false:
		move_to(target.global_transform.origin)
	if escape == true:
		#if ghost needs to escape, try to get to mirror position of player instead
		#x coordinate for center of pacman level
		var center_x = 62
		#formula to get proper inverse x position based on where center of level is
		var new_target_x = 2*center_x - target.global_transform.origin.x
		#the z just needs to be inverted because center lies at 0,0, y can stay the same
		var new_target_y = target.global_transform.origin.y
		var new_target_z = -target.global_transform.origin.z
		move_to(Vector3(new_target_x, new_target_y, new_target_z)) # Replace with function body.


func _on_GhostArea_body_entered(body):
	var player_body = get_owner().get_node("ARVROrigin/PlayerBody/KinematicBody")
	var arvrorigin = get_owner().get_node("ARVROrigin")
	if body != player_body:
		return
	if body == player_body:
		if escape == false:
			#code to set GhostSound to kill player sound and play
			$GhostSound.play()
			player_properties.lives-=1
			#arvrorigin.global_transform.origin = Vector3(0,0,0)
			
		if escape == true:
			#code to set GhostSound to eat ghost sound and play
			$GhostSound.play()
			player_properties.score+=player_properties.ghost_value
			self.global_transform.origin = ghost_starting_position
			
			
func attack_mode():
	escape = false
	$Ghost/Icosphere001.set_surface_material(0, normal_material)#code to switch material
	
func escape_mode():
	escape = true
	$Ghost/Icosphere001.set_surface_material(0, escape_material)
	#code to switch material


func _on_AnimationPlayer_animation_finished(anim_name):
	$Ghost/AnimationPlayer.play(anim_name)  # Replace with function body.
