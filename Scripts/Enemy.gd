extends MarginContainer

var isEnemyBeingAttacked = false
var cardName
var power
var simpleName
var colorName
var specialText

enum{
	faceDown,
	faceUp,
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
	
#	if $RayCast2D.is_colliding():
#		print("collision point: ",$RayCast2D.get_collision_point())
##		print ($RayCast2D.get_collider())
#	if $RayCast2D.get_collider() == $"../../EnemyCards": 
#		print("no")
#		$CardBack.visible = true
#	elif $RayCast2D.get_collider() == $"../../PlayspaceCollider": 
##			print("teh")
#		$CardBack.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $RayCast2D.is_colliding():
		var tempObject = $RayCast2D.get_collider()
#		print("collision point: ",$RayCast2D.get_collision_point())
#		print ($RayCast2D.get_collider())
		if tempObject.get_collision_mask_value(1):
			print("no")
			$CardBack.visible = true
		elif tempObject.get_collision_mask_value(2):
#			print("teh")
			$CardBack.visible = false
		else:
			$CardBack.visible = true
#	if $RayCast2D.is_colliding():
##		print("collision point: ",$RayCast2D.get_collision_point())
#		var tempObject = $RayCast2D.get_collider()
#		if tempObject.get_collision_mask_value(2):
#			print ("oh yeah")
