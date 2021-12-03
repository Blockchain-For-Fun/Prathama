extends Node2D

export(OpenSimplexNoise) var noise

const block_size = 8
const chunk_width = 256
const chunk_height = 512
const chunk_distance = 1
const chunk_limit = 9223372036854775807
const initial_block = Vector2(0, chunk_height/2) #This is the first block in existence and is where all heights are based from
var chunk_loaded_right = false
var chunk_loaded_left = false
var chunk_current_id = 0
var current_chunk_left_surface_height = initial_block.y
var current_chunk_right_surface_height
var block_current = 0

func _ready():
	#Determine player starting chunk
	var player_starting_position = $Player.get_position()
	chunk_current_id = floor(player_starting_position.x/(chunk_width * 8))
	var left_x = chunk_current_id * chunk_width
	
	#find height of starting chunk
	var generator_position = initial_block
	while generator_position.x != left_x:
		generator_position.y = get_surface_height(generator_position)
		generator_position.x = generator_position.x + 1
	
	#Start building chunck
	print(generator_position)
	load_chunk_right(chunk_current_id, generator_position.y)

func _process(delta):
	if chunk_loaded_left == false and $Player.get_position().x < chunk_width/2:
		#load left chunk
		pass
	elif chunk_loaded_right == false and $Player.get_position().x > chunk_width/2:
		#load right chunk
		pass
		
func load_chunk_left(id, surface_height):
	print("Loading Chunk " + str(id))
	var left_x = id * chunk_width
	var right_x = left_x + chunk_width
	var generator_position = Vector2(right_x, surface_height)
	while generator_position.x > left_x:
		generator_position.y = build_surface(generator_position)
		generator_position.x = generator_position.x - 1
	
func load_chunk_right(id, surface_height):
	print("Loading Chunk " + str(id))
	var left_x = id * chunk_width
	var right_x = left_x + chunk_width
	var generator_position = Vector2(left_x, surface_height)
	while generator_position.x < right_x:
		generator_position.y = build_surface(generator_position)
		generator_position.x = generator_position.x + 1
		
func build_surface(position):
	position.y = get_surface_height(position)
	$TileMap.set_cellv(position, 1)
	return position.y
		
func get_surface_height(position):
	var height_noise = noise.get_noise_2dv(position)
	if height_noise > 0.4:
		#go up
		position.y = position.y + 1
	elif height_noise < -0.4:
		#go down
		position.y = position.y - 1
		
	return position.y
