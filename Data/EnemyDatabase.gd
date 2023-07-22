extends Node
# Unitinfo = [Type, Power, Simple Name, Color, Special Text]
# Eventinfo = [Type, Cost, Effect]

enum {Bubble1White, Bubble2White, Bubble1Red, BubbleRescue}

const DATA = {
	
	Bubble1White :
		["Enemy", 1, "Bubble", "Neutral", ""],
		
	Bubble2White :
		["Enemy", 2, "Bubble", "Neutral", ""],
	
	Bubble1Red :
		["Enemy", 1, "Bubble", "Red", ""],
		
	BubbleRescue :
		["Rescue", 1, "Help me!", "Neutral", "Rescue the townsperson"]
}
