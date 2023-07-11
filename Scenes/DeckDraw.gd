extends TextureButton

var deckSize = INF
var isDealingCard = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	scale *= $"../../".cardSize.texture.get_size  # enable if you need to resize the cards (not tested)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _gui_input(event):
	if Input.is_action_just_released("leftclick"):
		if deckSize > 0:
			deckSize = $"../../".drawACard()
			
			if deckSize == 0:
				disabled = true #disables the deck and shows empty
				

		#same version of the function but with a timeout
#		if deckSize > 0:
#			if isDealingCard == false: #checks to see if a card is currently being dealt
#				isDealingCard = true
#				deckSize = $"../../".drawACard()
#
#
#			if deckSize == 0:
#				disabled = true #disables the deck and shows empty
#
#			await get_tree().create_timer(.1).timeout #prevents the player from drawing cards too fast, such as accidentally double-clicking
#			isDealingCard = false
		
