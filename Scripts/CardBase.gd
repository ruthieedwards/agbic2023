extends MarginContainer


# MEMBER VARIABLES
#@onready var cardDatabase = preload("res://data/cardDatabase.gd")
# instead, cardDatabase is Autoloaded as a global variable
# alternatively you could do this
#@onready var cardDatabaseTemp = cardDatabase.new()

var cardName
var startPos = 0
var targetPos = 0
var t = 0

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

var state = inHand

func _physics_process(delta):
	match state:
		inHand:
			pass
		inPlay:
			pass
		inMouse:
			pass
		focusedInHand:
			pass
		movingDrawnCardToHand: # animate from deck to hand
			pass
			position = startPos.linear_interpolate(targetPos,t)
		reorganizingHand:
			pass
			
			

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
