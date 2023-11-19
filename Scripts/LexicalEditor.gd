extends PanelContainer

var curEntry: Control = null

func _ready():
	hideEntry()

func showEntry(x):
	curEntry = x
	visible = true

func hideEntry():
	curEntry = null
	visible = false
