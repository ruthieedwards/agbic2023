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
var cardSpread = 0.25
var cardAngle = 0
var cardNumber = 0
var numCardsInHand = 0

# i feel like this shouldn't be here but it is
enum{
	inHand,
	inPlay,
	inMouse,
	focusedInHand,
	movingDrawnCardToHand,
	reorganizingHand,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func drawACard():
	cardAngle = PI/2 + cardSpread*(float(numCardsInHand)/2 - numCardsInHand)
	var newCard = cardBase.instantiate()
	randomCardSelected = randi() % deckSize
	newCard.cardName = playerHandTemp.cardList[randomCardSelected]
	
	#place the card along an oval
	ovalAngleVector = Vector2(horizRadius * cos(cardAngle), - vertRadius * sin(cardAngle))
	newCard.startPos = $Deck.position - newCard.size/2 # - cardSize/2 
	newCard.targetPos = centerCardOval + ovalAngleVector - newCard.size/2
	newCard.startRot = 0
	newCard.targetRot = (PI/2 - cardAngle)/4 
	#newCard.scale *= cardSize/newCard.size #enable if scaling needed
	newCard.currentCardState = movingDrawnCardToHand
	
	cardNumber = 0
	
	for card in $Cards.get_children(): # reorganize hand
		cardAngle = PI/2 + cardSpread*(float(numCardsInHand)/2 - cardNumber) 
		ovalAngleVector = Vector2(horizRadius * cos(cardAngle), - vertRadius * sin(cardAngle))
#		card.startPos = card.position
		card.targetPos = centerCardOval + ovalAngleVector - card.size/2 #- cardSize
		card.startRot = card.rotation
		card.targetRot = (PI/2 - cardAngle)/4 
#		card.targetRot = (90 - rad_to_deg(cardAngle))/4 #doesnt work?
		
		cardNumber += 1
		if card.currentCardState == inHand:
			card.currentCardState = reorganizingHand
			card.startPos = card.position
		elif card.currentCardState == movingDrawnCardToHand:
			card.startPos = card.targetPos - ((card.targetPos - card.position)/(1-card.t))
	

	
	print("deckSize =", deckSize)
	print("randomCardSelected =", randomCardSelected)
	
#	new_card.scale *= cardSize/new_card.size # enable if you need to resize the cards
	$Cards.add_child(newCard)
	print("newCard name: ",newCard.cardName)
#		print("Cards Group Count =", $Cards.get_child_count())
	playerHandTemp.cardList.erase(playerHandTemp.cardList[randomCardSelected])
	cardAngle += 0.3
	deckSize -= 1
	numCardsInHand += 1
#	cardNumber += 1
	return deckSize
#	print(playerHandTemp.cardList)
	
