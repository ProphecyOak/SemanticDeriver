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
	if Input.is_action_just_pressed("Grab"):
		if !holding and spotMousedOver != null and spotMousedOver.has_node("Draggable"):
			spotMousedOver.get_node("Draggable").grab()
		elif holding:
			if spotMousedOver == nodeHolding or spotMousedOver == null or spotMousedOver.isDescendantOf(nodeHolding) or spotMousedOver == nodeHolding.parentNode:
				nodeHolding.get_node("Draggable").release()
			elif spotMousedOver.branches < 2:
				print("%s to be placed at %s" % [nodeHolding.name, spotMousedOver.name])
				nodeHolding.parentNode.branches -= 1
				nodeHolding.get_parent().remove_child(nodeHolding)
				spotMousedOver.addChild(nodeHolding)
				nodeHolding.get_node("Draggable").release()
