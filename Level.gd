extends Node3D

const N = 0.0
const E = 90.0
const S = 180.0
const W = 270.0

const placeholder = preload("res://blocks/O.tscn")
const blockLibrary = {
	#"IEW": preload("res://blocks/IEW.tscn"),
	#"INS": preload("res://blocks/INS.tscn"),
	#"LES": preload("res://blocks/LES.tscn"),
	#"LNE": preload("res://blocks/LNE.tscn"),
	#"LNW": preload("res://blocks/LNW.tscn"),
	#"LSW": preload("res://blocks/LSW.tscn"),
	#"O": preload("res://blocks/O.tscn"),
	"PES": preload("res://blocks/PES.tscn"),
	"PNE": preload("res://blocks/PNE.tscn"),
	"PNW": preload("res://blocks/PNW.tscn"),
	"PSW": preload("res://blocks/PSW.tscn"),
	#"TESW": preload("res://blocks/TESW.tscn"),
	#"TNES": preload("res://blocks/TNES.tscn"),
	#"TNEW": preload("res://blocks/TNEW.tscn"),
	#"TNSW": preload("res://blocks/TNSW.tscn"),
	#"WESW": preload("res://blocks/WESW.tscn"),
	#"WNES": preload("res://blocks/WNES.tscn"),
	#"WNEW": preload("res://blocks/WNEW.tscn"),
	#"WNSW": preload("res://blocks/WNSW.tscn"),
	"X": preload("res://blocks/X.tscn")
}

var level = {}
var blocks = []
const row = 20
const col = 20
const maxX = 6
var lowestEntropy: int
var speed =  0.0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	blocks = loadBlockFromJson()
	lowestEntropy = blockLibrary.size()-1
	
	initalizeGridWithEntropy(row, col)
	drawLevel()
	
	collapseBlock(findLowestEntropy())

	var camera = get_tree().get_nodes_in_group("camera")[0]
	camera.position.x = camera.position.x + row - 1
	camera.position.z = camera.position.z + col - 1 
	camera.position.y = (row+col) * .75


# Called everz frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func initalizeGridWithEntropy(row, col): 
	for iRow in row: 
		level[iRow] = {}
		for iCol in col: 
			var entropy = lowestEntropy

			var block = placeholder.instantiate()
			block.entropy = entropy
			block.col = iCol
			block.row = iRow
			level[iRow][iCol] = block

func sort_ascending(a, b):
	if a.entropy < b.entropy:
		return true
	return false
	
func findLowestEntropy():
	var flat = flattenLevel()

	flat.sort_custom(sort_ascending)

	if flat.size() > 0:
		#todo get lowest value and select random from all matches
		return flat[0]
	else: 
		return null

	
func collapseBlock(block, prevBlock = null):
	block.collapsed = true	
	await get_tree().create_timer(speed).timeout 
	var neighbors

	if prevBlock == null:
		block.key = blockLibrary.keys()[randi() % blockLibrary.size()]
	else: 
		if prevBlock.row < block.row:
			print("attatching N")
			neighbors = blocks[prevBlock.key].neighbors.n
		elif prevBlock.row > block.row: 
			print("attatching S")
			neighbors = blocks[prevBlock.key].neighbors.s
		elif prevBlock.col < block.col: 
			print("attatching E")
			neighbors = blocks[prevBlock.key].neighbors.e
		elif prevBlock.col > block.col: 
			print("attatching W")
			neighbors = blocks[prevBlock.key].neighbors.w
		
		if neighbors.size() > 0:
			block.key = neighbors[randi() % neighbors.size()]
			print(prevBlock.key, " - ",neighbors)
		else: 
			#TODO - something with this condition
			block.key = "X"
			pass
	
	block.add_child(getBlockByKey(block.key))	
	block.removePlaceholder()
	
	lowestEntropy = block.entropy
	
	updateNeighbors(block)
	
	var nextBlock = findLowestEntropy()	
	if nextBlock != null:
		collapseBlock(nextBlock, block)


	

func updateNeighbors(block):
	updateN(block)
	updateE(block)
	updateS(block)
	updateW(block)

func updateN(block):
	if(block.row == 0): return
	if(level[block.row-1][block.col].collapsed): return

	var neighbor = level[block.row-1][block.col]
	neighbor.entropy = blocks[block.key].neighbors.n.size()

func updateE(block):
	if(block.col == col-1): return
	if(level[block.row][block.col+1].collapsed): return

	var neighbor = level[block.row][block.col+1]
	neighbor.entropy = blocks[block.key].neighbors.e.size()

func updateS(block):
	if(block.row == row-1): return
	if(level[block.row+1][block.col].collapsed): return

	var neighbor = level[block.row+1][block.col]
	neighbor.entropy = blocks[block.key].neighbors.s.size()

func updateW(block):
	if(block.col == 0): return
	if(level[block.row][block.col-1].collapsed): return

	var neighbor = level[block.row][block.col-1]
	neighbor.entropy = blocks[block.key].neighbors.w.size()		

func flattenLevel(): 
	var lvl = []
	for iRow in level: 
		for iCol in level[iRow]: 
			if !level[iRow][iCol].collapsed:
				lvl.append(level[iRow][iCol])
	return lvl
	
func drawLevel():
	for row in level: 
		for col in level[row]: 
			var block = level[row][col]
			block.position.z = col * 2
			block.position.x = row * 2
			add_child(block)	
	
func loadBlockFromJson(): 
	var jsonPath = "res://assets/utils/neighbors.json"
	var jsonText = FileAccess.get_file_as_string(jsonPath)
	return JSON.parse_string(jsonText)

func getBlockByKey(key):
	if key != null: 
		return blockLibrary[key].instantiate()
