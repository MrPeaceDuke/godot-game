extends Node2D

var currentScene = null

var PlayerName = "Andrey"

func getPlayerName():
	return PlayerName

var bestScore = 0

func getBestScore():
	return bestScore

func setBestScore(score):
	if score > bestScore:
		bestScore = score



func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	
func setScene(scene):
	currentScene.queue_free()
	var s = load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
