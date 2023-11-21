extends Node

var Lexicon: VBoxContainer
var SyntaxRoot: SyntaxNode
var OutputText: Label

# RUN DERIVATION
func go():
	recursiveGo(SyntaxRoot)

func recursiveGo(curNode: SyntaxNode):
	var leftOut = null
	var rightOut = null
	var nodeChildren = curNode.getNodeChildren()
	if curNode.branches == 0:
		return curNode.lexEntry.predicate
	if curNode.branches >= 1:
		leftOut = recursiveGo(nodeChildren[0])
	if curNode.branches == 2:
		rightOut = recursiveGo(nodeChildren[1])
	if !typesValid(curNode,nodeChildren):
		print("TYPE MISMATCH: %s does not match its children" % [curNode.label.text])

# CHECK THAT ALL NODES HAVE VALID CHILD TYPES
func typesValid(node: SyntaxNode, children):
	var childTypes = []
	var firstVars = []
	for x in children:
		childTypes.append(x.lexEntry.generateType())
		firstVars.append(x.lexEntry.variables[x.lexEntry.variables.keys()[0]])
	print(childTypes)
	print(firstVars)
	if len(children) == 1:
		return children[0].lexEntry.generateType() == node.lexEntry.generateType()
	else:
		#FIX THIS   FIX THIS   FIX THIS   FIX THIS
		return (childTypes[0] == firstVars[1] or childTypes[1] == firstVars[0])

#ELEPHANT    $x <e>. $s <s>. {x} is an elephant in {s} : <t>
#THE         $g <e,<s,t>>. The unique _x in _s such that {g}(x)(s) : <e>

# SPLIT TYPES INTO I/O
func splitType(nodeType):
	pass
