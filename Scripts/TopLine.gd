extends TextEdit

@export var VARIABLE_COLOR = Color("#41cc66")
@export var TYPE_COLOR = Color("#ffee80")
@export var FUNCTION_COLOR = Color("#ffee80")
@export var ARGUMENT_COLOR = Color("#ffee80")

var Lexicon: Control = null
var regex = RegEx.new()
var regex2 = RegEx.new()
var regex3 = RegEx.new()

func _ready():
	Lexicon = $"../../../../.."
	syntax_highlighter.add_color_region("$"," ", VARIABLE_COLOR)
	syntax_highlighter.add_color_region("<",".", TYPE_COLOR)
	syntax_highlighter.add_color_region("{","}", FUNCTION_COLOR)
	syntax_highlighter.add_color_region("(",")", ARGUMENT_COLOR)
	regex.compile("\\$(\\w+)\\s*(<[^\\.]+>)(?:\\s*\\.\\s*)")
	regex2.compile(".*\\.(.*):")
	regex3.compile(".*\\..*:\\s*(<[^\\.]+>).*")

func updateEntry():
	release_focus()
	Lexicon.curEntry.variables = {}
	var vars = regex.search_all(text)
	var pred = regex2.search(text)
	var yType = regex3.search(text)
	if vars == null or pred == null or yType == null:
		return
	for newMatch in vars:
		Lexicon.curEntry.variables[newMatch.get_string(1)] = newMatch.get_string(2)
	Lexicon.curEntry.predicate = pred.get_string(1)
	Lexicon.curEntry.yieldType = yType.get_string(1)


func textChanged():
	Lexicon.curEntry.lexText = text
