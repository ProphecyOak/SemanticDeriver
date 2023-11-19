extends Control

func _ready():
	for x in $"../Children".get_children():
		Global.panels.append(x)
		x.mouse_entered.connect(Global.onEnterDropSpot.bind($"..", x))
		x.mouse_exited.connect(Global.onExitDropSpot)

