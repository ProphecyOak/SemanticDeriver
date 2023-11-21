extends Button

func _ready():
	Deriver.OutputText = $"../Derived"

func copy():
	DisplayServer.clipboard_set($"../Derived".text)
