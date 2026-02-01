extends Node
var notePageDetails : Array[NotePageDetails] = [];
var current_description = -1;
var charactersFound : Array[Character_Enum.Characters] = [];
@onready var main_description: Label = $Character_Descriptions/MainDescription
@onready var top_description: Label = $Character_Descriptions/TopDescription
@onready var icon_texture: TextureRect = $CharacterIconContainer/CharacterIconMarginContainer/IconTexture
@onready var left_arrow: TextureRect = $left_arrow
@onready var right_arrow: TextureRect = $right_arrow
@onready var collective_1: Sprite2D = $Collective_1
@onready var collective_2: Sprite2D = $Collective_2
@onready var collective_3: Sprite2D = $Collective_3
@onready var collective_4: Sprite2D = $Collective_4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	characterFound(Character_Enum.Characters.PENGUIN);
	characterFound(Character_Enum.Characters.MOUSE);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(notePageDetails.size()>0):
		var new_description = 0 if current_description == -1 else  current_description;
		if(Input.is_action_just_pressed("next_page")):
			if (current_description < notePageDetails.size()-1):
				new_description = current_description +1;
		elif (Input.is_action_just_pressed("prev_page")):
			if(current_description > 0) :
				new_description = current_description -1;
		if (new_description != current_description):
			current_description = new_description;
			updatePageDescription();
	else:
		left_arrow.visible = false;
		right_arrow.visible = false;
		
	
func updatePageDescription() -> void:
	var details:NotePageDetails = notePageDetails[current_description];
	main_description.text = details.description;
	top_description.text = details.title;
	icon_texture.texture = details.icon;
	left_arrow.visible = false if current_description == 0 else true;
	right_arrow.visible = false if current_description == notePageDetails.size()-1 else true;
	
	
func characterFound(char:Character_Enum.Characters):
	if(!charactersFound.has(char)):
		charactersFound.push_back(char);
		notePageDetails.push_back(getCharDescription(char));
		updatePageDescription()
	
func getCharDescription(char: Character_Enum.Characters):
	match char:
		Character_Enum.Characters.MOLE:
			return NotePageDetails.new(preload("uid://chrcxxy83ud1y"),"Mr. Mole", "Mr. Mole is the splendid and generous privatier of the town. As unfullfilled as he feels in his private, he fills his social life to the brim: he is president of the Lions Club and the towns Golf Club. In his Mansion he holds different glorious parties - mask balls, benefit events, classic concerts, readings, banquets etc. Furthermore, he generously reserves a part of his park as outdoor area for the towns kindergarden. He is in a romantic relationship with Mr. Mouse");
		Character_Enum.Characters.BUNNY:
			return NotePageDetails.new(preload("uid://ckm3vba2p8t7h"),"Mrs. Rabbit","She is restless and nervous, always on the run. Mrs. Rabbit dedicates her live to her garden and vegetables she grows herself. She is a little bit afraid of that the new villager Mr. Fox will ambush her. This fear stems from an incident between her and Mr. Fox, when he moved into the house next door. Mrs. Rabbit wanted to welcome him with a homemade carrot cake. But this turned out to be a bad idea, since Mr. Fox ended up yelling at her and running into his house and slamming the door.")
		Character_Enum.Characters.FOX:
			return NotePageDetails.new(preload("uid://ch32gjy6c866b"),"Mr. Fox","Mr. Fox is a handy man always fixing stuff instead of bying something new. He just moved into the town. Although he is so helpful to the rest of the villagers, they don't fully trust him. This is because of the incident with Mrs. Rabbit, whom presented him with a homemade carrot cake not knowing that Mr. Fox is intolerate to vegtables, and his face swells to three times its original size just when getting close to vegetables.")
		Character_Enum.Characters.OWL:
			return NotePageDetails.new(preload("uid://bbheemlaj8bc8"),"Mrs. Owl", "Mrs. Owl is the village eldest. This is also why the other villagers come to her for advice. She manages the library. A patient job since she suffers from narcolepsy. Mrs. Owl appreciates good food. She is happy to have Mrs. Rabbit living close by, and provides her with fresh vegetables");
		Character_Enum.Characters.PENGUIN:
			return NotePageDetails.new(preload("uid://c4gqfpnkur0yk"),"Detective Penguin", ' You are Mr. Penguin, a famous detective. The police called you as soon as they received a weird call from Mr. Mouse right before his murder. His last words were "Mr. Mouse speaking. Come fast to Mole\'s Mansion someone tries to ..." ending apruptly with a smash noise and afterwards the phone tooting. Dutifully you jumped into your sledge and drove to Mole\'s Mansion. As soon as you arrived this is what you found in the study room ...');
		Character_Enum.Characters.SHRIMP:
			return NotePageDetails.new(preload("uid://bl1gshhjr41xi"),"Mr. Shrimp","Mr. Shrimp loves cleaning and keeping everything in order. No broom or rag is safe from him. He even cleans other people's houses just for fun");
		Character_Enum.Characters.CHAMELEON:
			return NotePageDetails.new(preload("uid://clmsx741mk35w"),"Mr. Chameleon","Mr. Chameleon is creative and also a little weird. He has the potential to become an famous artist one day. After his wife left he tried to overcome the pain in his paintings. Not all of the villagers appretiate his work. Anyway Mr. Mole is a big fan and calls himself Mr. Chameleons patron.")
		Character_Enum.Characters.MOUSE:
			return NotePageDetails.new(preload("uid://cicow3ecryqj0"),"Mr.Mouse","He died at the beginning of this mysterious murder case. Mr. Mouse was a beloved fellow. Everybody will miss him. So why would someone murder him? Was he just collateral damage or is there something more behind this allegedly white vested little creature? Questions over questions, gladly you are here to bring some light into the dark.");
		Character_Enum.Characters.CAT:
			return NotePageDetails.new(preload("uid://b4smrja4gfmsh"),"Mrs. Cat","Mrs. Cat is the femme fatal of the community. As smooth and cuddly as she may seem, she is actually rather a loner. She loves beautiful things and appreciates an asthetically pleasing environment");

func hintFound(hint: Character_Enum.Hints):
	match hint :
		Character_Enum.Hints.Invitation:
			collective_1.texture=preload("uid://d2j81gqoeykhn");
		Character_Enum.Hints.Carrot:
			collective_2.texture=preload("uid://d1n2ntswp0y6i");
		Character_Enum.Hints.Book:
			collective_3.texture=preload("uid://byprniyry2kfv");
		Character_Enum.Hints.Toolbox:
			collective_4.texture=preload("uid://bggf6apdoli85");
