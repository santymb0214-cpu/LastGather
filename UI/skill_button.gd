extends Button
class_name SkillButton 

@export var number: int

@onready var panel: Panel = $Panel
@onready var skill_icon: TextureRect = $Skillico
@onready var label: Label = $Label

func _ready() -> void:
	label.text = str(number)
	 
