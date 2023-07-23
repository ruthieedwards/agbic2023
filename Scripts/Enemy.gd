class_name Enemy extends MarginContainer

var isEnemyBeingAttacked = false
var cardName
var power
var simpleName
var colorName
var specialText
var cardType
var gridPosition = Vector2(0, 0)
var cardGridSize = Vector2(3, 3)
var cardIndex

enum{
	faceDown,
	faceUp,
	attacked,
	discarded,
}

var currentEnemyState = faceDown

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardSize = size
	var cardInfo = enemyDatabase.DATA[enemyDatabase.get(cardName)] #enemyDatabase autoloads globally
#	var cardInfo = cardDatabase.DATA[cardDatabase.get(cardName)]
#	var cardImg = str("res://Art/Cards/",cardInfo[0],"/",cardName,".png") #loads image
	
#	cardName = cardInfo[0]
	cardType = str(cardInfo[0])
	power = cardInfo[1]
	simpleName = str(cardInfo[2])
	colorName = str(cardInfo[3])
	specialText = str(cardInfo[4])
	
	var cardImg = str("res://Art/Cards/Enemy/",cardName,".png") #loads image
	$ImageContainer/CardImg.texture = load(cardImg) #sets image as texture
	scale *= .75
#	$ImageContainer/CardImg.scale *= $ImageContainer.get_minimum_size() / $ImageContainer/CardImg.texture.get_size()*.75   #scale if needed, idk if these are the right methods anyway
	
	$Bars/BottomBar/Power/CenterContainer/Power.text = str(power)
	$Bars/BottomBar/Color/CenterContainer/Color.text = colorName
	
	await get_tree().create_timer(.5).timeout
	$RayCast2D.enabled = true
	
	CalculateGridPosition()
	
func CalculateGridPosition():
	var row = cardIndex % int(cardGridSize.y)# Divide cardIndex by the number of columns to get the row
	var column = cardIndex % int(cardGridSize.x) # Use modulo operator to get the column
	gridPosition = Vector2(column, row)
	print("calculated grid pos")

func flipCardAbove():
	var aboveIndex = cardIndex - int(cardGridSize.x)
	print ("flipping above card")
	if aboveIndex >= 0:
		get_node("../../EnemyCards").get_child(aboveIndex).currentEnemyState = faceUp


func _process(delta):
	match currentEnemyState:
		faceDown:
			var belowIndex = cardIndex + int(cardGridSize.x)
			var numEnemies = $"../../".enemyHandTemp.enemyCardList.size()
			if belowIndex > numEnemies - 1: #offset for 0-index?
				currentEnemyState = faceUp
			pass
		faceUp:
			$CardBack.visible = false
		attacked:
			print ("killing enemy")
			flipCardAbove()
			currentEnemyState = discarded
#			UpdateCardVisibility()
		discarded:
			#reindex all the enemy cards
#			queue_free()
			visible = false
			
			
