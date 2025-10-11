extends Node2D
class_name Character

@export var max_health : int = 100
@export var current_health : int = max_health
@export var character_name : String
@export var speed : int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damage_character(damage : int) -> void:
	current_health-=damage

func heal_character(heal : int) -> void:
	current_health+=heal

func set_health(new_health :int) -> void:
	current_health = new_health
