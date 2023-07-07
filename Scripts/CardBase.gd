extends MarginContainer


# MEMBER VARIABLES
#@onready var cardDatabase = preload("res://data/cardDatabase.gd")
# instead, cardDatabase is Autoloaded as a global variable
# alternatively you could do this
#@onready var cardDatabaseTemp = cardDatabase.new()

var cardName
var startPos = 0
var targetPos = 0
var startRot = 0
var targetRot = 0
var t = 0
@export var drawTime =  .3 #time in seconds to draw card
var isTweening = false


# these were moved to the _ready() function
#@onready var cardInfo = cardDatabase.DATA[cardDatabase.get(cardName)]
#var cardImg = str("res://art/cards/backgrounds/",cardInfo[0],"/",Cardname,".png")
#@onready var cardImg = str("res://Art/Cards/",cardInfo[0],"/",cardName,".png")

# building a "state engine"
enum{
	inHand,
	inPlay,
	inMouse,
	focusedInHand,
	movingDrawnCardToHand,
	reorganizingHand,
}

var currentCardState = inHand

func _physics_process(delta):
	match currentCardState:
		inHand:
			pass
		inPlay:
			pass
		inMouse:
			pass
		focusedInHand:
			pass
		movingDrawnCardToHand: # animate from deck to hand
			#Tweening in Godot 4.0
			var tween = create_tween()
			tween.tween_property(self, "position", targetPos, drawTime).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "rotation", targetRot, drawTime).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			
			# movement using lerp instead of tweens
			if t <= 2: # while the timer is counting down
#				position = startPos.lerp(targetPos,t) # moves from deck to hand
##				rotation = startRot * (1-t) + targetRot*t # rotates from deck to hand
				t += delta/float(drawTime) # essentially a timer
#
#
			else: #if the time goes over by accident
				position = targetPos
				rotation = targetRot
				currentCardState = inHand
				t = 0
			#TO DO: flip the card (vid 3 - I skipped this step)
			
		reorganizingHand:
			if t <= 1: # while the timer is counting down
				position = startPos.lerp(targetPos,t) # moves from deck to hand
				rotation = startRot * (1-t) + targetRot*t # rotates from deck to hand
				t += delta/float(drawTime) # essentially a timer
			else: #if the time goes over by accident
				position = targetPos
				rotation = targetRot
				currentCardState = inHand
				t = 0
			
			

func _ready(): 
	var cardInfo = cardDatabase.DATA[cardDatabase.get(cardName)]
	var cardImg = str("res://Art/Cards/",cardInfo[0],"/",cardName,".png")
#	print(CardInfo)
	var cardSize = size
	$CardImg.texture = load(cardImg)
#	$Card.scale *= cardSize/$Card.texture.get_size() # scale card if needed
	# $Border.scale *= cardSize/$Border.texture.get_size()
	
	# grabbing all the card's properties
	var power = cardInfo[1]
	var simpleName = str(cardInfo[2])
	var colorName = str(cardInfo[3])
	var specialText = str(cardInfo[4])
	
	# setting all the card's text
	$Bars/TopBar/Name/CenterContainer/Name.text = simpleName
	$Bars/TopBar/Power/CenterContainer/Power.text = str(power)
	$Bars/BottomBar/SpecialText/CenterContainer/SpecialText.text = specialText
	$Bars/BottomBar/Color/CenterContainer/Color.text = colorName
