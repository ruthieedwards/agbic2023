extends MarginContainer

var maxEnergy = 3
var currentEnergy


# Called when the node enters the scene tree for the first time.
func _ready():
	currentEnergy = maxEnergy
	$Bars/EnergyText.text = str("Energy: ",currentEnergy)
	$Bars/EnergyBar.value = currentEnergy
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func DepleteHealthBar():
	pass


func _on_attack_initiated(attackPower, enemyPower):
	
	if attackPower >= enemyPower:
		print("hi")
		pass

