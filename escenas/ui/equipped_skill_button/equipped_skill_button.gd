extends Button
class_name EquippedSkillButton

@export var number: int

@onready var panel: Panel = $Panel
@onready var skill_icon: TextureRect = $SkillIcon
@onready var label: Label = $Label

func _ready() -> void:
	label.text = str(number)
