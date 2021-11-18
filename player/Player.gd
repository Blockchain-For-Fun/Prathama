extends KinematicBody2D

const up = Vector2(0,-1)
const gravity = 20
const max_fall_speed = 200
const max_movement_speed = 80
const jump_speed = 300

var motion = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	
	# Handle gravity
	motion.y += gravity
	motion.y = clamp(motion.y, -INF, max_fall_speed)
	
	
	# Handle right and left strafe
	if Input.is_action_pressed("right"):
		motion.x = max_movement_speed
	elif Input.is_action_pressed("left"):
		motion.x = -max_movement_speed
	else:
		motion.x = 0
		
	if Input.is_action_just_pressed("up") and is_on_floor():
		motion.y = -jump_speed
		
	motion = move_and_slide(motion, up)
