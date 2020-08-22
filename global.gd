extends Node2D

var settings_file = "res://settings.save"

var PlayerName = "Andrey"
var bestScore = 0


func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(PlayerName)
	f.store_var(bestScore)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		PlayerName = f.get_var()
		bestScore = f.get_var()
		f.close()


var currentScene = null


func getPlayerName():
	return PlayerName



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
