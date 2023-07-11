extends MarginContainer


# MEMBER VARIABLES

#@onready var cardDatabase = preload("res://data/cardDatabase.gd")
# instead, cardDatabase is Autoloaded as a global variable
# alternatively you could do this I think
#@onready var cardDatabaseTemp = cardDatabase.new()

var cardName
var startPos = 0
var targetPos = 0
var startRot = 0
var targetRot = 0
var t = 0
@export var drawTime =  .3 #time in seconds to draw card
@export var organizeTime = .1
@export var zoomInTime = .1 #time in seconds to zoom in on a card
@export var zoomOutTime = .1 #time in seconds to zoom out from a card
var isTweening = false
var isSettingUp = true
var startScale = Vector2(0,0)
var zoomScale = 1.4
@onready var originalScale = scale
var defaultCardPos = Vector2(0,0)
var isReorganizingNeighbors = true
var numCardsInHand = 0
var cardNumInHand
var neighborCard
var isMovingNeighborCard = false
var currentCardState = inHand

# these were moved to the _ready() function
#@onready var cardInfo = cardDatabase.DATA[cardDatabase.get(cardName)]
#var cardImg = str("res://art/cards/backgrounds/",cardInfo[0],"/",Cardname,".png")
#@onready var cardImg = str("res://Art/Cards/",cardInfo[0],"/",cardName,".png")

# repeating the state engine here
enum{
	inHand,
	inPlay,
	inMouse,
	focusedInHand,
	movingDrawnCardToHand,
	reorganizingHand,
}


func _physics_process(delta):
	match currentCardState:
		inHand:
			pass
		inPlay:
			pass
		inMouse:
			pass


		focusedInHand:
			print("isSettingUp : ",cardName,isSettingUp)
#			if isSettingUp == true:
#				SetupTransition() 
				#disabled bc this was causing the middle cards not to work for some reason
				#however it doesn't shift the cards over
			if t <= 1: 
				print("zooming in: ",cardName)
				print ("scale 1: ",scale)
				position = startPos.lerp(targetPos,t) # moves from deck to hand
				rotation = startRot * (1-t) + 0*t # + targetRot*t # rotates from deck to hand
				scale = startScale * (1-t) + originalScale*zoomScale*t
#				scale = Vector2(2,2)
				print ("scale 2: ",scale)
				t += delta/float(zoomInTime) # timer
				#reorganize neighboring cards while focused on one
				if isReorganizingNeighbors == true:
					isReorganizingNeighbors = false
					numCardsInHand = $"../../".numCardsInHand - 1 # offset for zero-index array
					if cardNumInHand - 1 >= 0:
						MoveNeighborCard(cardNumInHand -1, true, 1) #card, left = true, scooch factor
					if cardNumInHand - 2 >= 0:
						MoveNeighborCard(cardNumInHand -2, true, .25)
					if cardNumInHand + 1 <= numCardsInHand:
						MoveNeighborCard(cardNumInHand +1, false, 1)
					if cardNumInHand + 2 <= numCardsInHand:
						MoveNeighborCard(cardNumInHand +2, false, .25)
					#do something else if there are more than 4 cards
				
				
			else: #if the time goes over by accident
				position = targetPos
				rotation = 0 
				scale = originalScale*zoomScale

		movingDrawnCardToHand: # animate from deck to hand
			#Tweening in Godot 4.0
			if isSettingUp == true:
				SetupTransition()
			var tween = create_tween()
			tween.tween_property(self, "position", targetPos, drawTime).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.parallel().tween_property(self, "rotation", targetRot, drawTime).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			
			# movement using lerp instead of tweens
			if t <= 1: 
#				position = startPos.lerp(targetPos,t) # moves from deck to hand
#				rotation = startRot * (1-t) + targetRot*t # rotates from deck to hand
#				scale.x = originalScale.x * abs(2*t -1) #this flips the card around, kinda ugly
				t += delta/float(drawTime) # essentially a timer

			else: #if the time goes over by accident this essentially clamps it
				position = targetPos
				rotation = targetRot
				currentCardState = inHand
				t = 0
			#TO DO: flip the card (3 - I skipped this step)


		reorganizingHand:
			if isSettingUp == true:
				SetupTransition()
#				print("setting up card name: ",cardName)
			if t <= 1: 
				if isMovingNeighborCard == true:
						isMovingNeighborCard = false
				position = startPos.lerp(targetPos,t) # move to target position
				rotation = startRot * (1-t) + targetRot*t # rotate to target rotation
				scale = startScale * (1-t) + originalScale*t #scale to original scale
				t += delta/float(organizeTime) # set transition time with organizeTime
				if isReorganizingNeighbors == false:
					isReorganizingNeighbors = true
					if cardNumInHand - 1 >= 0:
						ResetCardOrganization(cardNumInHand - 1)
					if cardNumInHand - 2 >= 0:
						ResetCardOrganization(cardNumInHand - 2)
					if cardNumInHand + 1 <= numCardsInHand:
						ResetCardOrganization(cardNumInHand + 1)
					if cardNumInHand + 2 <= numCardsInHand:
						ResetCardOrganization(cardNumInHand + 2)
					
			else: #if the time goes over by accident this essentially clamps it
				position = targetPos
				rotation = targetRot
				scale = originalScale
				currentCardState = inHand
			
			
			


	
	
func MoveNeighborCard(cardNumber, isLeft, spreadAmount):
	neighborCard = $"../".get_child(cardNumber)
	if isLeft:
		neighborCard.targetPos = neighborCard.defaultCardPos - spreadAmount*Vector2(65,0) #move to the left - guess-and-check the vector2 number
	else:
		neighborCard.targetPos = neighborCard.defaultCardPos + spreadAmount*Vector2(65,0) #move to the right
	neighborCard.isSettingUp = true
	neighborCard.currentCardState = reorganizingHand
	neighborCard.isMovingNeighborCard = true

func ResetCardOrganization(cardNumber): #set to original position
	neighborCard = $"../".get_child(cardNumber)
	if neighborCard.isMovingNeighborCard == false:
		neighborCard = $"../".get_child(cardNumber)
		if neighborCard.currentCardState != focusedInHand:
			neighborCard.currentCardState = reorganizingHand
			neighborCard.targetPos = neighborCard.defaultCardPos
			neighborCard.isSettingUp = true
			
	
func SetupTransition(): #grabs the starting properties for the card
	print("setting up ",cardName)
	startPos = position
	startRot = rotation
	startScale = scale
	t = 0
	isSettingUp = false
			

func _ready(): #called when node enters the scene tree
	var cardSize = size
	var cardInfo = cardDatabase.DATA[cardDatabase.get(cardName)]
	var cardImg = str("res://Art/Cards/",cardInfo[0],"/",cardName,".png") #loads image
	$CardImg.texture = load(cardImg) #sets image as texture
#	$Card.scale *= cardSize/$Card.texture.get_size() # scale card if needed
#	$Border.scale *= cardSize/$Border.texture.get_size()
#	$HoverFocus.scale *= cardSize/$HoverFocus.size()
	
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


func _on_hover_focus_mouse_entered():
	match currentCardState:
		inHand, reorganizingHand:
			print("mouse focused on: ",cardName)
			isSettingUp = true
			targetPos = defaultCardPos
			targetPos.y = get_viewport().size.y - (size.y)*zoomScale + (size.y*.2) #change size.y to $"../../".cardSize.y (2 nodes up) if using scaling
			currentCardState = focusedInHand


func _on_hover_focus_mouse_exited():
	match currentCardState:
		focusedInHand:
			isSettingUp = true
			targetPos = defaultCardPos
			currentCardState = reorganizingHand
