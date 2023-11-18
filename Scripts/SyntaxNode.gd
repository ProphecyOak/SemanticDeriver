extends Control

@export var root = false
@export var packedNode: PackedScene

var parentNode: VBoxContainer = null
var branches = 0

func _ready():
	if !root:
		print("%s created under %s" % [self, parentNode])
	else:
		print("%s created with no parent" % self)
	

func addChild(node = null):
	if branches < 2:
		branches += 1
		if node == null:
			node = packedNode.instantiate()
		$Children.add_child(node)
		node.parentNode = self
		node.packedNode = packedNode

func _process(_delta):
	if Input.is_action_just_pressed("Debug") and Global.spotMousedOver == self:
		addChild()

func isDescendantOf(node):
	if root:
		return false
	if node == parentNode:
		return true
	return parentNode.isDescendantOf(node)
