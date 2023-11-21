extends PanelContainer

var curEntry: Control = null
var topLine: Control = null

func _ready():
	hideEntry()
	topLine = $"MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/TextEdit"

func showEntry(x):
	curEntry = x
	topLine.text = x.lexText
	visible = true

func hideEntry():
	curEntry = null
	visible = false

func _input(_event):
	if Input.is_key_pressed(KEY_ENTER):
		if topLine.has_focus():
			get_viewport().set_input_as_handled()
			topLine.updateEntry()
