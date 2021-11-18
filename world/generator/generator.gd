extends Position2D

export(PackedScene) var block

var block_size = 8
var blocks_on_screen = 240
var current_block_number = 0

# Create variables for seeded-random
var rng = RandomNumberGenerator.new()
var genessis_seed = 4207354715 # Placeholder until I have a genessis block
var rng_state = rng.get_state()
var movment_probabilities = []

signal instance_node(node, location)

func _ready():
	#Set-up seeded-random
	rng.set_seed(genessis_seed)
	# Create a sorted range of random values within the min and max values of int
	# This will determine the probability of moving generator up or down
	movment_probabilities.append(rng.randi_range(-9223372036854775807, 9223372036854775807))
	movment_probabilities.append(rng.randi_range(-9223372036854775807, movment_probabilities[0]))
	movment_probabilities.append(rng.randi_range(-9223372036854775807, movment_probabilities[0]))
	print(movment_probabilities)

func _process(delta):
	if Global.world != null:
		if !is_connected("instance_node", Global.world, "instance_node"):
			connect("instance_node", Global.world, "instance_node")
		
	if current_block_number < blocks_on_screen:
		var movement = rng.randi_range(-9223372036854775807, 9223372036854775807)
		
		# Move Up
		if movement > movment_probabilities[1] and movement <= movment_probabilities[2]:
			global_position.y += block_size
		# Move Down
		elif movement > movment_probabilities[2]:
			global_position.y -= block_size
			
		# Limit max ground height
		global_position.y = clamp(global_position.y, 270, 810)
		
		global_position.x += block_size
		emit_signal("instance_node", block, global_position)
		current_block_number += 1
	else:
		queue_free()
