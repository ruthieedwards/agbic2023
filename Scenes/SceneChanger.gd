extends Control

var gameScene = 'res://Scenes/PlaySpace.tscn'
var titleScreen = 'res://Scenes/TitleScreen.tscn'
var levelSelect = 'res://Scenes/LevelSelect.tscn'
@export var levelNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func GoToTitle():
	get_tree().change_scene_to_file(titleScreen)
	
func GoToLevelSelect():
	get_tree().change_scene_to_file(levelSelect)
	
func GoToGame():
	get_tree().change_scene_to_file(gameScene)
	
func ChangeLevel():
	$"../../LevelText".text = str("Level ",levelNumber)
#	get_node("../LevelText").text = str("Level ",levelNumber)
#	$Bars/EnergyText.text = str("Energy: ",currentEnergy)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
