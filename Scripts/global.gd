extends Node

var spotMousedOver: Control = null
var panelOver: Control = null
var holding = false
var nodeHolding: Control = null
var panels = []
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
		if editMode == "Create":
			if spotMousedOver != null and panelOver != null:
				if spotMousedOver.branches < 2:
					spotMousedOver.addChild(null,panelOver)
		if editMode == "Destroy":
			if spotMousedOver != null:
				if !spotMousedOver.root:
					spotMousedOver.deleteNode()
	if Input.is_action_just_released("Grab"):
		if editMode == "Move" and holding:
			triggerPanels(false)
			if (spotMousedOver == nodeHolding or
				spotMousedOver == null or
				panelOver == null or
				spotMousedOver.isDescendantOf(nodeHolding) or
				spotMousedOver == nodeHolding.parentNode or
				spotMousedOver.branches == 2):
				nodeHolding.get_node("Draggable").release()
			elif spotMousedOver.branches < 2:
				nodeHolding.parentNode.branches -= 1
				nodeHolding.get_parent().remove_child(nodeHolding)
				spotMousedOver.addChild(nodeHolding,panelOver)
				nodeHolding.get_node("Draggable").release()

func changeEditMode(mode):
	editMode = mode
	if editMode == "Create":
		triggerPanels(true)
	else:
		triggerPanels(false)
	if editMode != "Move":
		holding = false
		nodeHolding = null

func triggerPanels(state):
	if state:
		for panel in panels:
			if panel.get_node("../..").branches < 2:
				panel.visible = true
				panel.visible = true
	else:
		for panel in panels:
			resetHighlight(panel)
			panel.visible = false
