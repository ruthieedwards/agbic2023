extends MarginContainer

var isEnemyBeingAttacked = false
var cardName
var power
var simpleName
var colorName
var specialText

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardSize = size
	var cardInfo = enemyDatabase.DATA[enemyDatabase.get(cardName)] #enemyDatabase autoloads globally
#	var cardInfo = cardDatabase.DATA[cardDatabase.get(cardName)]
#	var cardImg = str("res://Art/Cards/",cardInfo[0],"/",cardName,".png") #loads image
	
#	cardName = cardInfo[0]
	power = cardInfo[1]
	simpleName = str(cardInfo[2])
	colorName = str(cardInfo[3])
	specialText = str(cardInfo[4])
	
	var cardImg = str("res://Art/Cards/Enemy/",cardName,".png") #loads image
	print("res://Art/Cards/Enemy/",cardName,".png")
	$ImageContainer/CardImg.texture = load(cardImg) #sets image as texture
#	$ImageContainer/CardImg.scale *= $ImageContainer.get_minimum_size() / $ImageContainer/CardImg.texture.get_size()   #scale if needed, idk if these are the right methods anyway
	$Bars/BottomBar/Power/CenterContainer/Power.text = str(power)
	$Bars/BottomBar/Color/CenterContainer/Color.text = colorName
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
