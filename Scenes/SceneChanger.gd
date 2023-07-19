extends Control

var gameScene = 'res://Scenes/PlaySpace.tscn'
var titleScreen = 'res://Scenes/TitleScreen.tscn'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func GoToTitle():
	get_tree().change_scene_to_file(titleScreen)
	
func GoToGame():
	get_tree().change_scene_to_file(gameScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
