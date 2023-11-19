extends VBoxContainer

@export var lexRow: PackedScene

func newRow(node):
	var row = lexRow.instantiate()
	row.syntaxNode = node
	add_child(row)
	return row
