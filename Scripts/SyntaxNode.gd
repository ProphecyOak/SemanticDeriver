extends Control

@export var root = false
@export var packedNode: PackedScene
@export var lexicon: Control
@export var colorBacking: ColorRect

var parentNode: VBoxContainer = null
var branches = 0
var lexEntry: Control
var label: LineEdit

func _ready():
	label = $Label/Name
	if root:
		lexEntry = lexicon.newRow(self)
		lexEntry.get_node("MarginContainer/HBoxContainer/Name").text = "S"
		$Label/Name.text = "S"

func addChild(node = null,panel=null):
	if branches < 2 or panel in [1,2]:
		branches += 1
		if node == null:
			node = packedNode.instantiate()
			node.lexEntry = lexicon.newRow(node)
		$Children.add_child(node)
		if branches == 2:
			if panel in [1,2]:
				$Children.move_child(node,panel)
			else:
				$Children.move_child(node,panel.name.to_int())
		else:
			$Children.move_child(node,1)
		node.parentNode = self
		node.packedNode = packedNode
		node.lexicon = lexicon
	if branches == 1 and Global.editMode == "Create":
		$"Children/1".visible = true
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
	Global.nodeTexts.erase($"Label/Name")
	lexEntry.deleteNode()
	queue_free()


func labelChanged(new_text):
	lexEntry.get_node("Name").text = new_text
