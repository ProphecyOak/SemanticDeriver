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

func addChild(node = null,panel=null):
	if branches < 2:
		branches += 1
		if node == null:
			node = packedNode.instantiate()
			node.lexEntry = Lexicon.newRow(node)
		$Children.add_child(node)
		if branches == 2:
			$Children.move_child(node,panel.name.to_int())
		else:
			$Children.move_child(node,1)
		node.parentNode = self
		node.packedNode = packedNode
		node.Lexicon = Lexicon
	if branches == 2:
		$"Children/1".visible = false
		$"Children/2".visible = false

func isDescendantOf(node):
	if root:
		return false
	if node == parentNode:
		return true
	return parentNode.isDescendantOf(node)

func deleteNode():
	parentNode.branches -= 1
	for child in $Children.get_children():
		if child.name in ["1","2"]:
			Global.panels.erase(child)
		else:
			child.deleteNode()
	lexEntry.queue_free()
	queue_free()
