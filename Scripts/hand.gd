extends Node2D
var card_preset = preload("res://Scenes/Character/Player/card.tscn")
var hand_array : Array = []
var selected_card : Node2D = null # card that is being dragged and is not in hand or snapped
var selected_card_index : int = 0 # index of selected card in hand_array
var top_card : Node2D = null
var all_cards = null
var all_cards_size = null


@export var base_radius: float = 50.0  # Distance from center to card

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		var newCard : Node2D = card_preset.instantiate()
		add_card(newCard)

func _process(delta: float) -> void:
	all_cards = get_tree().get_nodes_in_group("card")
	all_cards_size = all_cards.size()
	check_each_card()
	find_top_card()
	update_hand_layout(delta)
	check_selected_card()

func add_card(card: Node2D) -> void :
	add_child(card)
	hand_array.append(card) # Adds card to hand array

func remove_card_from_hand(card: Node2D) -> void:
	hand_array.erase(card)

#func add_card_to_hand(card: Node2D) -> void:
#	hand_array.insert(card.hand_index, card)

func check_each_card() -> void:
	for i in range(all_cards_size):
		var card = all_cards[i]
		if card.get_node("dragger").selected:
			selected_card = card

func check_selected_card() -> void: # Checks the selected card and adds back to hand if not snapped or selected
	if selected_card != null:
		var dragger : Node2D =  selected_card.get_node("dragger")
		if not dragger.snapped and not dragger.selected and dragger.overlapped_snappers.size() == 0:
			dragger.rest_point = Vector2.ZERO
			hand_array.insert(selected_card_index, selected_card)
			selected_card = null
		if dragger.snapped:
			selected_card = null

func find_top_card() -> void:
	var hovered_cards : Array = []
	var card_count : int = hand_array.size()
	for i in range(card_count):
		var card : Node2D = hand_array[i]
		if card.get_node("dragger").hovered:
			hovered_cards.append(card)
	var hovered_size : int = hovered_cards.size()
	if hovered_size != 0:
		for i in range(hovered_cards.size()):
			hovered_cards[i].get_node("dragger").is_top_card = false
		hovered_cards[hovered_size - 1].get_node("dragger").is_top_card = true
		top_card = hovered_cards[hovered_size - 1]

func update_hand_layout(delta) -> void:
	var card_count : int = hand_array.size()
	var to_be_removed : Node2D = null
	if card_count == 0:
		return

	var angleOne : int = -50 # left hand angle
	var angleTwo : int = 50 # right hand angle
	var angleStep : float = (angleTwo - angleOne) / float(card_count + 1)

	for i in range(card_count):
		var card_radius : int = base_radius
		var card : Node2D = hand_array[i]
		card.z_index = i
		card.hand_index = i
		if card.get_node("dragger").selected: #sets card for removal and saves index
			to_be_removed = card
			selected_card_index = i
		var angle_deg : int =  angleOne + (i + 1) * angleStep
		var angle_rad : float = deg_to_rad(angle_deg)

		if card.get_node("dragger").is_top_card and card == top_card:
			if base_radius != 50:
				card_radius += 10
				card.z_index = 100
		#polar coords -> cartesian coords
		var x : float = card_radius * sin(angle_rad)
		var y : float = -card_radius * cos(angle_rad)


		card.position = lerp(card.position, Vector2(x, y), delta * 20)
		card.rotation_degrees = angle_deg * 0.5

	if to_be_removed != null:
		remove_card_from_hand(to_be_removed)
		selected_card = to_be_removed
		selected_card.rotation_degrees = 0

#increases radius of hand and increases available space to choose cards
func _on_area_2d_mouse_entered() -> void:
	base_radius = 200
	$initial.monitoring = false
	$initial.input_pickable = false
	$initial.visible = false

	$final.monitoring = true
	$final.input_pickable = true
	$final.visible = true

#opposite of above
func _on_final_mouse_exited() -> void:
	base_radius = 50
	$final.visible = false
	$final.monitoring = false
	$final.input_pickable = false

	$initial.visible = true
	$initial.monitoring = true
	$initial.input_pickable = true
