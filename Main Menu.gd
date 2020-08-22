extends Node2D

var globalVars = null

func _ready():
	globalVars = get_node("/root/globals")
	print(globalVars.getBestScore())
	$TextureButton.connect("pressed", self, "_pressed_btn")
	$bestScoreLabel.text = "Best score - " + str(globalVars.getBestScore())
	

func _pressed_btn():
	globalVars.setScene("res://Main scene.tscn")
