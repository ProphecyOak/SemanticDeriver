extends Node

var spotMousedOver: Control = null
var panelOver: Control = null
var holding = false
var nodeHolding: Control = null
var panels = []
var nodeTexts = []
var editMode = "Create"

func onEnterDragSpot(node):
	spotMousedOver = node

func onExitDragSpot():
	spotMousedOver = null

func onEnterDropSpot(node, spot=null):
	spotMousedOver = node
	panelOver = spot
	highlight(panelOver)

func onExitDropSpot():
	resetHighlight(panelOver)
	spotMousedOver = null
	panelOver = null

func resetHighlight(node):
	node.color = Color(.37,.37,.37)
func highlight(node):
	node.color = Color(.8,.8,.8)

func _process(_delta):
	if Input.is_action_just_pressed("Grab"):
		if editMode == "Move" and !holding:
			if spotMousedOver != null and spotMousedOver.has_node("Draggable"):
				spotMousedOver.get_node("Draggable").grab()
				triggerPanels(true)
				triggerOppositeChildPanels(spotMousedOver)
		if editMode == "Create":
			if spotMousedOver != null and panelOver != null and spotMousedOver.branches < 2:
				if panelOver.visible:
					spotMousedOver.addChild(null,panelOver)
		if editMode == "Destroy":
			if spotMousedOver != null:
				if !spotMousedOver.root:
					spotMousedOver.deleteNode()
	if Input.is_action_just_released("Grab"):
		if editMode == "Move" and holding:
			if spotMousedOver == null:
				nodeHolding.get_node("Draggable").release()
			elif (spotMousedOver == nodeHolding or
				  spotMousedOver.isDescendantOf(nodeHolding) or
				  panelOver == null):
				nodeHolding.get_node("Draggable").release()
			elif spotMousedOver.branches < 2 or nodeHolding.parentNode == spotMousedOver:
				nodeHolding.parentNode.branches -= 1
				nodeHolding.get_parent().remove_child(nodeHolding)
				spotMousedOver.addChild(nodeHolding,panelOver)
				nodeHolding.get_node("Draggable").release()
		if editMode == "Exchange" and holding:
			pass #TO ADD POTENTIALLY??
		triggerPanels(false)

func changeEditMode(mode):
	editMode = mode
	triggerPanels(editMode == "Create")
	triggerTextBoxes(editMode == "Edit")
	if editMode != "Move":
		holding = false
		nodeHolding = null

func triggerOppositeChildPanels(node):
	if node.parentNode.branches == 2:
		node.parentNode.get_node("Children/"+str(3 - node.get_index())).visible = true

func triggerPanels(state):
	if state:
		for panel in panels:
			var node = panel.get_node("../..")
			if editMode == "Move":
				if (node.parentNode == nodeHolding or
					node == nodeHolding or
					node == nodeHolding.parentNode or
					node.isDescendantOf(nodeHolding)):
					continue
			if node.branches == 0 and panel.name == "2":
				panel.visible = true
			if node.branches == 1:
				panel.visible = true
				panel.visible = true
	else:
		for panel in panels:
			resetHighlight(panel)
			panel.visible = false

func triggerTextBoxes(state):
	for textBox in nodeTexts:
		textBox.editable = state
