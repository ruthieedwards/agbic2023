extends MarginContainer

var maxRescues = 3
var currentRescues


# Called when the node enters the scene tree for the first time.
func _ready():
	currentRescues = 0
	$Bars/RescuesText.text = str("Remaining Townspeople: ", maxRescues - currentRescues)
	$Bars/RescuesBar.value = maxRescues - currentRescues
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func DepleteHealthBar():
#	pass

#
#func _on_attack_initiated(attackPower, enemyPower):
#
#	if attackPower >= enemyPower:
#		print("woopa")
#		pass
#
