extends Node3D
var label3d
var camera

var entropy: int
var col: int
var row: int
var key: String

var collapsed = false

func _ready():
	label3d = Label3D.new() # Create a new Sprite2D.
	label3d.position.y = 1.25
	label3d.font_size = 50
	add_child(label3d) # Add it as a child of this node.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collapsed:
		label3d.text = key

	camera = get_tree().get_nodes_in_group("camera")
	if camera:
		label3d.rotation = camera[0].rotation
	
func removePlaceholder():
	#$".".print_tree_pretty()
	$block.queue_free()
	
