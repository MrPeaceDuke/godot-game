extends Node2D

var lifes = 3
var coins = 0

var timer = null
var timerDelay = 1.5
var rand = null
var screen_size = null
var level = null

func _ready():
	level = get_tree().get_root().get_node("Main scene")
	$deathLine.connect("area_entered", self, "_deathToExplosion")
	$Character/Area2D.connect("area_entered", self, "_take")
	rand = RandomNumberGenerator.new()
	screen_size = get_viewport().get_visible_rect().size
	
	$Camera2D/LabelLife.text = "Lifes - " + str(lifes)
	$Camera2D/LabelCoins.text = str(coins) + " coins"
	
	timer = Timer.new()
	timer.set_wait_time(timerDelay)
	timer.connect("timeout", self, "_random_generation_bomb")
	timer.connect("timeout", self, "_random_generation_coin")
	add_child(timer)
	timer.start()
	
func _take(object):
	var owner = object.get_owner()
	#print(owner.name)
	if "coin" in owner.name:
		owner.queue_free()
		coins += 1
		$Camera2D/LabelCoins.text = str(coins) + " coins"
		if coins%3==0 and timerDelay > 0.1:
			timerDelay -= 0.1
		timer.set_wait_time(timerDelay)
		#print(timerDelay)
	if "bomb" in owner.name:
		owner.get_child(0).hide()
		owner.get_child(1).play("explosion")
		lifes -= 1
		$Camera2D/LabelLife.text = "Lifes - " + str(lifes)
		if lifes < 1:
			get_node("/root/globals").setBestScore(coins)
			get_node("/root/globals").save_settings()
			get_node("/root/globals").setScene("res://Main Menu.tscn")
			

func _deathToExplosion(object):
	var owner = object.get_owner()
	if "bomb" in owner.name:
		owner.get_child(0).hide()
		owner.get_child(1).play("explosion")
		#owner.get_child(1).connect("animation_finished", self, "_death")
		#owner.queue_free()
		

func _random_generation_coin():
	var coinTile = load("res://Coin.tscn")
	var coin = coinTile.instance()
	coin.position.x = rand_range(-755, 1530)
	coin.position.y = rand_range(580, 610)
	coin.gravity_scale = int(rand_range(5, 40))
	var name = "coin "+str(rand_range(0,1000))
	coin.set_name(name)
	add_child_below_node(level, coin)
	coin.get_child(2).connect("area_entered", self, "_bombOnCoin")

func _bombOnCoin(object):
	var owner = object.get_owner()
	if "bomb" in owner.name:
		owner.get_child(0).hide()
		owner.get_child(1).play("explosion")

func _random_generation_bomb():
	var bombTile = load("res://bomb.tscn")
	var bomb = bombTile.instance()
	bomb.position.x = rand_range(-755, 1530)
	bomb.position.y = rand_range(-500, -screen_size.y)
	bomb.gravity_scale = int(rand_range(5, 50))
	var name = "bomb "+str(rand_range(0,1000))
	bomb.set_name(name)
	add_child_below_node(level, bomb)
