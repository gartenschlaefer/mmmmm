# --
# guest character

class_name GuestCharacter extends Node2D

# resources
@export var dialogue: Dialogue

# refs
@onready var interaction_area: Area2D = $interaction_area
@onready var rufzeichen: Sprite2D = $rufzeichen


func _ready():
	
	# signal connection
	interaction_area.area_entered.connect(self.on_area_entered)
	interaction_area.area_exited.connect(self.on_area_exited)

	# hide rufzeichen
	rufzeichen.hide()


func get_dialogue() -> Dialogue: return dialogue


func on_area_entered(_area: Area2D):

	# rufzeichen
	rufzeichen.show()


func on_area_exited(_area: Area2D):

	# rufzeichen
	rufzeichen.hide()
