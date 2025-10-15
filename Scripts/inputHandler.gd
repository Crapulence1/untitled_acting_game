extends Node
var card_preset = preload("res://Scenes/card.tscn")
var handRef: Node2D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	allInput()
	pass


func allInput() -> void:
	if Input.is_action_just_pressed("drawCard"):
		var newCard : Node2D = card_preset.instantiate()
		newCard.add_to_group("handCards")
		handRef.add_child(newCard)
	
	if Input.is_action_pressed("escape"):
		get_tree().quit()
