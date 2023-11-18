extends Control

@export var root = false
@export var packedNode: PackedScene
@export var Lexicon: Control

var parentNode: VBoxContainer = null
var branches = 0
var lexEntry: Control

func _ready():
	if root:
		lexEntry = Lexicon.newRow(self)
		lexEntry.get_node("ScrollContainer/HBoxContainer/Name").text = "S"
		$Label/Name.text = "S"

func addChild(node = null):
	if branches < 2:
		branches += 1
		if node == null:
			node = packedNode.instantiate()
			lexEntry = Lexicon.newRow(node)
		$Children.add_child(node)
		node.parentNode = self
		node.packedNode = packedNode
		node.Lexicon = Lexicon

func isDescendantOf(node):
	if root:
		return false
	if node == parentNode:
		return true
	return parentNode.isDescendantOf(node)
