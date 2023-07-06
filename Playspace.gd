extends Node2D

# DECLARE MEMBER VARIABLES
# created as soon as the scene is instantiated unless you use @onready
# const cardSize = Vector2(125,175) # enable if you need to resize the cards
const cardBase = preload("res://Scenes/CardBase.tscn")
@onready var playerHand = preload ("res://Scripts/PlayerHand.gd")
@onready var playerHandTemp = playerHand.new()
var randomCardSelected = []
@onready var deckSize = playerHandTemp.cardList.size()

#formula for drawing an oval
#xcoords = radius1 * cos of the angle
#ycoords = radius2 * sin of the angle

@onready var viewportSize = Vector2(get_viewport().size)
@onready var centerCardOval = viewportSize * Vector2(0.5, 1.25)
@onready var horizRadius = get_viewport().size.x * 0.45
@onready var vertRadius = get_viewport().size.y * 0.4
var startingAngle = deg_to_rad(90) - 0.5 # pi/2
var ovalAngleVector = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func drawACard():
	var newCard = cardBase.instantiate()
	randomCardSelected = randi() % deckSize
	newCard.cardName = playerHandTemp.cardList[randomCardSelected]
	
	#place the card along an oval
	ovalAngleVector = Vector2(horizRadius * cos(startingAngle), - vertRadius * sin(startingAngle))
	newCard.position = centerCardOval + ovalAngleVector - newCard.size/2
	newCard.rotation = (PI/2 - startingAngle)/4 
	
	print("deckSize =", deckSize)
	print("randomCardSelected =", randomCardSelected)
	
	
#	new_card.scale *= cardSize/new_card.size # enable if you need to resize the cards
	$Cards.add_child(newCard)
	print("newCard name: ",newCard.cardName)
#		print("Cards Group Count =", $Cards.get_child_count())
	playerHandTemp.cardList.erase(playerHandTemp.cardList[randomCardSelected])
	startingAngle += 0.3
	deckSize -= 1
	return deckSize
#	print(playerHandTemp.cardList)
	
