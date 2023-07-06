extends Node2D

# DECLARE MEMBER VARIABLES
# created as soon as the scene is instantiated unless you use @onready
# const cardSize = Vector2(125,175) # enable if you need to resize the cards
const cardBase = preload("res://Scenes/CardBase.tscn")
@onready var playerHand = preload ("res://Scripts/PlayerHand.gd")
@onready var playerHandTemp = playerHand.new()
var randomCardSelected = []
@onready var deckSize = playerHandTemp.cardList.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if Input.is_action_just_released("leftclick"):
		
		var newCard = cardBase.instantiate()
		randomCardSelected = randi() % deckSize
		newCard.cardName = playerHandTemp.cardList[randomCardSelected]
		newCard.position = get_global_mouse_position()
		
		print("deckSize =", deckSize)
		print("randomCardSelected =", randomCardSelected)
		
		
#		new_card.scale *= cardSize/new_card.size # enable if you need to resize the cards
		$Cards.add_child(newCard)
		print("newCard name: ",newCard.cardName)
#		print("Cards Group Count =", $Cards.get_child_count())
		playerHandTemp.cardList.erase(playerHandTemp.cardList[randomCardSelected])
		deckSize -= 1
		print(playerHandTemp.cardList)
