extends TextureButton

var deckSize = INF
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
				disabled = true
			
