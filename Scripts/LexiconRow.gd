extends ColorRect
class_name LexiconRow

var syntaxNode: SyntaxNode
var editor: Control

var variables = {}
var lexText = ""
var predicate = ""
var yieldType = ""


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

func generateType():
	var out = "<"
	for x in variables.keys():
		out += variables[x].substr(1,-1)
	out += ",%s>" % yieldType
	return out
