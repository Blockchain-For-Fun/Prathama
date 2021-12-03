extends TileMap

const block_size = 8
const chunk_width = 256
const chunk_height = 512
const chunk_load_distance = 1
var block_current = 0
var chunk_current = 0

# Create variables for seeded-random
var noise = OpenSimplexNoise.new()
var genessis_seed = 420735471 # Placeholder until I have a genessis block

func _ready():
	#Set-up seeded-random
	noise.seed = genessis_seed
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	#Set-up starting position
	for chunk in chunk_load_distance:
		for block in 
	
	while block_current < chunk_width:
		var movement = rng.randi()
		
		# Move Up
		if movement > movement_probabilities[1] and movement <= movement_probabilities[2]:
			global_position.y += block_size
		# Move Down
		elif movement > movement_probabilities[2]:
			global_position.y -= block_size
			
		# Limit max ground height
		global_position.y = clamp(global_position.y, 270, 810)
		
		global_position.x += block_size
		emit_signal("instance_node", dirt_grass, global_position)
		#build_row(global_position)
#		var thread = Thread.new()
#		thread.start(self, "build_row", global_position)
		block_current += 1

func build_row(position):
	for i in range(position.y-1, chunk_height-position.y):
		emit_signal("instance_node", dirt, Vector2(position.x, i))
