class_name Enemy extends MarginContainer

var isEnemyBeingAttacked = false
var cardName
var power
var simpleName
var colorName
var specialText
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
#	UpdateCardVisibility()
	
#	if $RayCast2D.is_colliding():
#		print("collision point: ",$RayCast2D.get_collision_point())
##		print ($RayCast2D.get_collider())
#	if $RayCast2D.get_collider() == $"../../EnemyCards": 
#		print("no")
#		$CardBack.visible = true
#	elif $RayCast2D.get_collider() == $"../../PlayspaceCollider": 
##			print("teh")
#		$CardBack.visible = false
	
func CalculateGridPosition():
	var row = cardIndex % int(cardGridSize.y)# Divide cardIndex by the number of columns to get the row
	var column = cardIndex % int(cardGridSize.x) # Use modulo operator to get the column
	gridPosition = Vector2(column, row)
	print("calculated grid pos")
	
#func UpdateCardVisibility():
#	pass

func flipCardAbove():
	var aboveIndex = cardIndex - int(cardGridSize.x)
	print ("running flip card")
#	var numEnemies = $"../../".enemyHandTemp.enemyCardList.size()
#	if aboveIndex < numEnemies - 1: #offset for 0-index?
	if aboveIndex >= 0:
#		currentEnemyState = faceUp #get the other card and flip face up
		print("flipping")
		get_node("../../EnemyCards").get_child(aboveIndex).currentEnemyState = faceUp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if $RayCast2D.is_colliding():
#		var tempObject = $RayCast2D.get_collider()
##		print("collision point: ",$RayCast2D.get_collision_point())
#		print ($RayCast2D.get_collider())
#		if tempObject is Enemy:
#			print("no")
#			$CardBack.visible = true
#		elif tempObject != null:
##			print("teh")
#			$CardBack.visible = false
#		else:
#			$CardBack.visible = true

#	if $RayCast2D.is_colliding():
##		print("collision point: ",$RayCast2D.get_collision_point())
#		var tempObject = $RayCast2D.get_collider()
#		if tempObject.get_collision_mask_value(2):
#			print ("oh yeah")
#	var collidingCard = raycast.get_collider()
#    if collidingCard != null:
	
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
#			print ("discarded enemy #",cardIndex)
			#reindex all the enemy cards
#			queue_free()
			visible = false
			
			
