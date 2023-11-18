extends Node

var spotMousedOver: Control = null
var holding = false
var nodeHolding: Control = null

func onEnterSpot(spot):
	spotMousedOver = spot
	if holding and spotMousedOver != nodeHolding:
		spotMousedOver.get_node("Label").color = Color(.5, .5, .5)

func onExitSpot():
	if holding and spotMousedOver != nodeHolding:
		resetHighlight()
	spotMousedOver = null

func resetHighlight():
	if spotMousedOver != null:
		spotMousedOver.get_node("Label").color = Color(.25,.25,.25)

func _process(_delta):
	if Input.is_action_just_pressed("Grab") and !holding:
			if spotMousedOver != null and spotMousedOver.has_node("Draggable"):
				spotMousedOver.get_node("Draggable").grab()
	if Input.is_action_just_released("Grab") and holding:
			if (spotMousedOver == nodeHolding or spotMousedOver == null or
				spotMousedOver.isDescendantOf(nodeHolding) or
				spotMousedOver == nodeHolding.parentNode or
				spotMousedOver.branches == 2):
				nodeHolding.get_node("Draggable").release()
			elif spotMousedOver.branches < 2:
				nodeHolding.parentNode.branches -= 1
				nodeHolding.get_parent().remove_child(nodeHolding)
				spotMousedOver.addChild(nodeHolding)
				nodeHolding.get_node("Draggable").release()
	if Input.is_action_just_pressed("Create"):
		if spotMousedOver != null:
			if spotMousedOver.branches < 2:
				spotMousedOver.addChild()
