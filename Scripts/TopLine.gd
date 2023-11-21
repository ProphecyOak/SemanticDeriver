extends TextEdit

@export var VARIABLE_COLOR = Color("#41cc66")
@export var TYPE_COLOR = Color("#ffee80")

var Lexicon: Control = null
var regex = RegEx.new()

func _ready():
	Lexicon = $"../../../../.."
	syntax_highlighter.add_color_region("$"," ", VARIABLE_COLOR)
	syntax_highlighter.add_color_region("<",".", TYPE_COLOR)
	
	regex.compile("\\$(\\w+)\\s*(<[^\\.]+>)(?:\\s*\\.\\s*)")

func updateEntry():
	release_focus()
	Lexicon.curEntry.variables = {}
	for newMatch in regex.search_all(text):
		Lexicon.curEntry.variables[newMatch.get_string(1)] = newMatch.get_string(2)
	print(Lexicon.curEntry.variables)


func textChanged():
	Lexicon.curEntry.lexText = text
