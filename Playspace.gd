extends Node2D

# DECLARE MEMBER VARIABLES
# created as soon as the scene is instantiated unless you use @onready
const cardSize = Vector2(125*2,175*2) # the full size
#const cardSize = Vector2(125,175) # enable if you need to resize the cards to half size
const cardBase = preload("res://Scenes/CardBase.tscn")
@onready var playerHand = preload ("res://Scripts/PlayerHand.gd")
@onready var enemyHand = preload ("res://Scripts/EnemyHand.gd")
@onready var enemy = preload ("res://Scenes/Enemy.tscn")
@onready var playerHandTemp = playerHand.new()
@onready var enemyHandTemp = enemyHand.new()

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
var isDealingCard = false

@onready var deckPosition = $Deck.position
#var isEnemyBeingAttacked

# i feel like this shouldn't be here but it is
enum{
	discarded,
	inHand,
	attacking,
	inMouse,
	focusedInHand,
	movingDrawnCardToHand,
	reorganizingHand,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	generateEnemyGrid()
	#deal 3 cards
	await get_tree().create_timer(.5).timeout
	drawACard()
	await get_tree().create_timer(.25).timeout
	drawACard()
	await get_tree().create_timer(.25).timeout
	drawACard()

func generateEnemyGrid():
	for e in enemyHandTemp.enemyCardList.size():
		print("emeyCardList size=  ",enemyHandTemp.enemyCardList.size())
		drawAnEnemy(e, enemyHandTemp.enemyCardList[e-1])
		pass
	
	for e in $EnemyCards.get_children():
		e.visible = true
		#position them somewhere
#		e.scale *= .5 #if need to scale

func drawAnEnemy(enemyNum, enemyName):
	var newEnemy = enemy.instantiate()
#	enemyNum -= 1
#	newEnemy.position = get_viewport().size*.05 + Vector2(200,0) #change this 
	newEnemy.position.x = enemyNum % 4 * 250 + 200
	newEnemy.position.y = floor(enemyNum / 4) * 250 + 20
	newEnemy.cardName = enemyHandTemp.enemyCardList[enemyNum]
	$EnemyCards.add_child(newEnemy)


func drawACard():
	
	cardAngle = PI/2 + cardSpread*(float(numCardsInHand)/2 - numCardsInHand)
	var newCard = cardBase.instantiate()
	randomCardSelected = randi() % deckSize
	newCard.cardName = playerHandTemp.cardList[randomCardSelected]
	
	#place the card along an oval
	ovalAngleVector = Vector2(horizRadius * cos(cardAngle), - vertRadius * sin(cardAngle))
	#newCard.startPos = $Deck.position - newCard.size/2 
	newCard.startPos = deckPosition - cardSize/2 #  #bugfix
	print("deck pos = ",deckPosition)
	print("newCard.startPos = ",newCard.startPos)
	newCard.targetPos = centerCardOval + ovalAngleVector - cardSize/2 #idk why i added /2 but it works
	newCard.defaultCardPos = newCard.targetPos #sets a default position for when un-focusing it
	print("newCard.targetPos = ",newCard.targetPos)
	print("newCard.defaultCardPos = ",newCard.defaultCardPos)
	newCard.startRot = 0
	newCard.targetRot = (PI/2 - cardAngle)/4 
	newCard.scale *= cardSize/newCard.size #enable if scaling needed
	newCard.currentCardState = movingDrawnCardToHand
	
	newCard.cardNumInHand = numCardsInHand
	cardNumber = 0
	
	#reorganize all the cards in hand
	for card in $CardsInHand.get_children(): 
		cardAngle = PI/2 + cardSpread*(float(numCardsInHand)/2 - cardNumber)
		ovalAngleVector = Vector2(horizRadius * cos(cardAngle), - vertRadius * sin(cardAngle))
#		card.startPos = card.position
		card.targetPos = centerCardOval + ovalAngleVector - card.size/2 #- cardSize
		card.defaultCardPos = card.targetPos
		card.startRot = card.rotation
		card.targetRot = (PI/2 - cardAngle)/4 
#		card.targetRot = (90 - rad_to_deg(cardAngle))/4 #doesnt work?
		card.cardNumInHand = cardNumber #0?
		cardNumber += 1
		if card.currentCardState == inHand:
			card.currentCardState = reorganizingHand
			card.startPos = card.position #unneeded?
		elif card.currentCardState == movingDrawnCardToHand:
			card.startPos = card.targetPos - ((card.targetPos - card.position)/(1-card.t))


	
	print("deckSize =", deckSize)
#	print("randomCardSelected =", randomCardSelected)
	
#	new_card.scale *= cardSize/new_card.size # enable if you need to resize the cards
	$CardsInHand.add_child(newCard)
	newCard.position = newCard.startPos
#	print("newCard name: ",newCard.cardName)
#	print("Cards Group Count =", $Cards.get_child_count())
	playerHandTemp.cardList.erase(playerHandTemp.cardList[randomCardSelected])
	cardAngle += 0.3
	deckSize -= 1
	numCardsInHand += 1
#	cardNumber += 1
	return deckSize
#	print(playerHandTemp.cardList)
	
