extends Control

func _ready():
	if $"..".root:
		queue_free()
	$"../Label".mouse_entered.connect(Global.onEnterDragSpot.bind($".."))
	$"../Label".mouse_exited.connect(Global.onExitDragSpot)

func grab():
	Global.holding = true
	Global.nodeHolding = $".."
	$"../Label".color = Color(.5, .5, .5)

func release():
	Global.holding = false
	Global.nodeHolding = null
	$"../Label".color = Color(.25,.25,.25)
