extends Spatial

onready var voxel = $VoxelLodTerrain

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Shoot_shot_hit(position, collider):
	var vt = voxel.get_voxel_tool()
	vt.mode = VoxelTool.MODE_REMOVE
	vt.do_sphere(position, 2.5)
