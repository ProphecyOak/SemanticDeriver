extends VBoxContainer

@export var lexRow: PackedScene

func newRow(node):
	var row = lexRow.instantiate()
	row.syntaxNode = node
	row.editor = $"../../../../CenterPanel/Lexical Editor"
	if node.root:
		row.get_node("MarginContainer/HBoxContainer/VBoxContainer/Delete").queue_free()
	add_child(row)
	return row
