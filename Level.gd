extends Node3D

const N = 0.0
const E = 90.0
const S = 180.0
const W = 270.0

const blockLibrary = {
	"IEW": preload("res://blocks/IEW.tscn"),
	"INS": preload("res://blocks/INS.tscn"),
	"LES": preload("res://blocks/LES.tscn"),
	"LNE": preload("res://blocks/LNE.tscn"),
	"LNW": preload("res://blocks/LNW.tscn"),
	"LSW": preload("res://blocks/LSW.tscn"),
	"O": preload("res://blocks/O.tscn"),
	"PES": preload("res://blocks/PES.tscn"),
	"PNE": preload("res://blocks/PNE.tscn"),
	"PNW": preload("res://blocks/PNW.tscn"),
	"PSW": preload("res://blocks/PSW.tscn"),
	"TESW": preload("res://blocks/TESW.tscn"),
	"TNES": preload("res://blocks/TNES.tscn"),
	"TNEW": preload("res://blocks/TNEW.tscn"),
	"TNSW": preload("res://blocks/TNSW.tscn"),
	"WESW": preload("res://blocks/WESW.tscn"),
	"WNES": preload("res://blocks/WNES.tscn"),
	"WNEW": preload("res://blocks/WNEW.tscn"),
	"WNSW": preload("res://blocks/WNSW.tscn"),
	"X": preload("res://blocks/X.tscn")
}

const maxX = 6

# Called when the node enters the scene tree for the first time.
func _ready():

	var blocks = loadBlockFromJson()

	var xIndex = 0
	var zIndex = 0

	for key in blocks:
		var block = blockLibrary[key].instantiate()
		block.position.x = xIndex * 2
		block.position.z = zIndex * 2
		add_child(block)
		xIndex += 1
		if(xIndex > maxX):
			xIndex = 0
			zIndex += 1		


# Called everz frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func loadBlockFromJson(): 
	var jsonPath = "res://assets/utils/neighbors.json"
	var jsonText = FileAccess.get_file_as_string(jsonPath)
	return JSON.parse_string(jsonText)
