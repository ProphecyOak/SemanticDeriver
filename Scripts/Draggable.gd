extends Control

func _ready():
	if $"..".root:
		queue_free()
	Global.nodeTexts.append($"../Label/Name")
	$"../Label/Name".mouse_entered.connect(Global.onEnterDragSpot.bind($".."))
	$"../Label/Name".mouse_exited.connect(Global.onExitDragSpot)

func grab():
	Global.holding = true
	Global.nodeHolding = $".."
	$"..".colorBacking.color = Color(.5, .5, .5)

func release():
	Global.holding = false
	Global.nodeHolding = null
	$"..".colorBacking.color = Color(.25,.25,.25)
