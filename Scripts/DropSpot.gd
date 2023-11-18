extends Control

func _ready():
	$"../Label".mouse_entered.connect(Global.onEnterSpot.bind($".."))
	$"../Label".mouse_exited.connect(Global.onExitSpot)

