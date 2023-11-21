extends ColorRect
class_name LexiconRow

var syntaxNode: Control
var editor: Control

var variables = {}


func textChanged(new_text):
	syntaxNode.get_node("Label/Name").text = new_text

func onDelete():
	syntaxNode.deleteNode()

func onShow():
	var hasSelf = editor.curEntry == self
	editor.hideEntry()
	if !hasSelf:
		editor.showEntry(self)
		editor.topLine.grab_focus()

func deleteNode():
	if editor.curEntry == self:
		editor.hideEntry()
	queue_free()
