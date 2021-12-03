extends KinematicBody2D

#Movement Vars
const up = Vector2(0,-1)
const gravity = 5
const movement_speed_max = 80
const jump_strength = 100
const max_fall_speed = 200
var motion = Vector2()

#Animation Vars
var facing_right = true

func _ready():
	$AnimationPlayer.play("Idle")
	
func _physics_process(delta):
	#Handle movement
	motion.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * movement_speed_max
	motion.y += gravity
	motion.y = clamp(motion.y, -INF, max_fall_speed)
		
	if Input.is_action_just_pressed("up") and is_on_floor():
		motion.y = -jump_strength
		
	motion = move_and_slide(motion, up)
	
	#Handle animation
	if facing_right != true and motion.x > 0:
		facing_right = true
		$Sprite.scale.x = 1
		$CollisionShape2D.position.x = 0
	elif facing_right != false and motion.x < 0:
		facing_right = false
		$Sprite.scale.x = -1
		$CollisionShape2D.position.x = 8
	
