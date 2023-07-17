extends MarginContainer

var maxHealth = 1
var currentHealth


# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	$Bars/HealthText.text = str("Health: ",currentHealth)
	$Bars/HealthBar.value = currentHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
