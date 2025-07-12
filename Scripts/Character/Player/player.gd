extends Node2D
var health : int = 100 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func damage_player(damage) -> void:
	health-=damage

func heal_player(heal) -> void:
	health+=heal

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
