extends Node
var notePageDetails : Array[NotePageDetails] = [];
var current_description = 0;
@onready var main_description: Label = $Character_Descriptions/MainDescription
@onready var top_description: Label = $Character_Descriptions/TopDescription
@onready var icon_texture: TextureRect = $CharacterIconContainer/CharacterIconMarginContainer/IconTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Mr Mole
	notePageDetails.push_back(NotePageDetails.new(preload("uid://chrcxxy83ud1y"),"Mr. Mole", "Er ist ein famoser Privatier der Stadt. So unerfüllt er sich im Privaten fühlt, so sehr befüllt er sein gesellschaftliches Leben: er hält den Vorsitz im Lions Club sowie Golfclub der Stadt. In seinem Anwesen veranstaltet er verschiedene Aktivitäten; (Masken-)Bälle, Benefiz-Ausstellungen, Musikkonzerte, Lesungen, Banquet etc. Zudem hält er wohlwollend einen Teil seines Parks als Außenbereich für den Kindergarten frei - weit weg von der Villa, unten am Bach. Insgeheim liebt er Herrn Maus."));;
	#test
	notePageDetails.push_back(NotePageDetails.new(preload("uid://chrcxxy83ud1y"),"Mr. Mole", "Er ist ein famoser Privatier der Stadt. So unerfüllt er sich im Privaten fühlt, so sehr befüllt er sein gesellschaftliches Leben: er hält den Vorsitz im Lions Club sowie Golfclub der Stadt"));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_description = current_description
	if(Input.is_action_just_pressed("next_page")):
		if (current_description < notePageDetails.size()-1):
			new_description = current_description +1;
	elif (Input.is_action_just_pressed("prev_page")):
		if(current_description > 0) :
			new_description = current_description -1;
	if (new_description != current_description):
		current_description = new_description;
		updatePageDescription();
	
func updatePageDescription() -> void:
	var details:NotePageDetails = notePageDetails[current_description];
	main_description.text = details.description;
	top_description.text = details.title;
	icon_texture.texture = details.icon;
	
	
	
