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
	if curNode.branches >= 1:
		leftOut = recursiveGo(nodeChildren[0])
	if curNode.branches == 2:
		rightOut = recursiveGo(nodeChildren[1])
	return curNode

# CHECK THAT ALL NODES HAVE VALID CHILD TYPES
func checkTypes():
	pass

# SPLIT TYPES INTO I/O
func splitType(nodeType):
	pass
