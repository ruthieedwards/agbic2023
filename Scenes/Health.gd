extends MarginContainer

var maxHealth = 1
var currentHealth


# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	$Bars/HealthText.text = str("Health: ",currentHealth)
	$Bars/HealthBar.value = currentHealth
	
#	get_node("../CardsInHand/CardBase").connect("attacked",DepleteHealthBar())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	$Bars/HealthBar.value = currentHealth
#	$Bars/HealthText.text = str("Health: ",currentHealth)
	pass


func DepleteHealthBar():
	pass
#this doesn't work bc it's not in the same node tree!!!!
#func _on_card_base_attack(attackPower, enemyPower):
#	print ("received emission")
#	if attackPower >= enemyPower:
#		pass
#		#doesn't affect health
#	if attackPower < enemyPower: 
#		currentHealth -= enemyPower - attackPower 
#		print("current health :",currentHealth)
#	pass # Replace with function body.


func _on_attack_initiated(attackPower, enemyPower):
	
	if attackPower >= enemyPower:
		pass
		#kill card
		#maybe do an animation
		#doesn't affect health

	if attackPower < enemyPower: 
		currentHealth -= enemyPower - attackPower 
		$Bars/HealthBar.value = currentHealth
		$Bars/HealthText.text = str("Health: ",currentHealth)
		
	LoseGameCheck()
	
func LoseGameCheck():
	if currentHealth <= 0:
		print("you lost")
