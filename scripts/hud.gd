# --
# hud

class_name Hud extends CanvasLayer

# vars
@onready var notepage = $notepage 
@onready var dialogue_panel = $dialogue_panel 


func _ready():
	pass


func get_notepage(): return notepage
func get_dialogue_panel(): return dialogue_panel
