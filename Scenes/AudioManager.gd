extends AudioStreamPlayer2D

# SOUND
var cardDealSound1 = preload("res://Audio/Card_Deals/card_deal_1.wav")
var cardDealSound2 = preload("res://Audio/Card_Deals/card_deal_2.wav")
var cardDealSound3 = preload("res://Audio/Card_Deals/card_deal_3.wav")
var cardDealSound4 = preload("res://Audio/Card_Deals/card_deal_4.wav")


func _ready():
	pass 

func _process(delta):
	pass

func DestroySelf():
	queue_free()


func _on_playspace_dealt_card():
	var randomNum = randi() % $CardSounds/Deals.get_child_count()
	$CardSounds/Deals.get_child(randomNum).play()
	
	
