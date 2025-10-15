extends Node2D
@export var image : Sprite2D
@export var cost : int
@export var cardName : String
var isTopCard : bool = false
var mouseOverCard : bool = false
var handIndex : int
var slot
var latestSetPosition : Vector2 = Vector2(0,0)
var dragging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	returnToLatestPosition(delta)
	drag()
	pass

func drag() -> void:
	if mouseOverCard:
		var highestIndex = 0
		for card in get_tree().get_nodes_in_group("hoveredCards"): # finds highest index for every hovered card
			if card.handIndex > highestIndex:
				highestIndex = card.handIndex
		if handIndex == highestIndex : #sets topCard
			isTopCard = true
		else:
			isTopCard = false
		if  Input.is_action_pressed("click") and isTopCard:
			global_position = get_global_mouse_position()
			dragging = true
			rotation = 0
		if Input.is_action_just_released("click"):
			dragging = false
			if slot != null:
				latestSetPosition = slot.global_position
				rotation = 0
		if Input.is_action_just_pressed("checkCardInfo"):
			print("position: " + str(position))
			print("rotation: " + str(rotation))
			print(z_index)
			print(isTopCard)
			print(slot)
			print("Slot position" + str(slot.position))
		
		
	
func returnToLatestPosition(delta) -> void:
	if not dragging:
		position = lerp(position, latestSetPosition, 10*delta)
	pass


func _on_dragger_mouse_entered() -> void:
	mouseOverCard = true
	add_to_group("hoveredCards")
	pass # Replace with function body.


func _on_dragger_mouse_exited() -> void:
	mouseOverCard = false
	remove_from_group("hoveredCards")
	isTopCard = false
	pass # Replace with function body.
