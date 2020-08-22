extends Node2D

var globalVars = null

func _ready():
	if globalVars == null:
		get_node("/root/globals").load_settings()
	globalVars = get_node("/root/globals")
	print(globalVars.getBestScore())
	$TextureButton.connect("pressed", self, "_pressed_btn")
	$bestScoreLabel.text = "Best score - " + str(globalVars.getBestScore())
	self.connect("tree_exiting", self, "_exitApp")
	

func _pressed_btn():
	globalVars.setScene("res://Main scene.tscn")

func _exitApp():
	
	print("exit")
