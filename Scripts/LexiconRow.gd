extends ColorRect
class_name LexiconRow

var syntaxNode: Control


func textChanged(new_text):
	syntaxNode.get_node("Label/Name").text = new_text
