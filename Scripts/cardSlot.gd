extends Node2D
var assignedCard : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	var card = area.get_parent()
	assignedCard = area.get_parent()
	card.slot = self
	card.add_to_group("slottedCards")
	card.remove_from_group("handCards")

func _on_area_2d_area_exited(area: Area2D) -> void:
	var card = area.get_parent()
	if assignedCard == card:
		card.slot = null
		card.remove_from_group("slottedCards")
		card.add_to_group("handCards")
		
		assignedCard = null
