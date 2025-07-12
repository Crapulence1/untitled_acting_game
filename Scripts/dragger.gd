extends Node2D

var is_inside_snapper : bool = false
var selected : bool = false
var card = preload("res://Scenes/hand.tscn")
var rest_point : Vector2 = Vector2(0,0)
var hovered : bool = false
var cards = null
var card_count = null
var snapped : bool = false
var is_top_card : bool = false
var can_be_selected : bool = false
var overlapped_snappers : Array = []

func _ready():
	cards = get_tree().get_nodes_in_group("card")
	card_count = cards.size()

func _process(delta):
	#print(card_count)
	if overlapped_snappers.size() == 0:
		snapped = false
	if selected and hovered:
		var snap_count : int = overlapped_snappers.size()
		for i in range(card_count): #makes sure only one card can get selected 
			var other_card : Node2D = cards[i]
			if other_card.get_node("dragger") != self:
				other_card.get_node("dragger").selected = false
				other_card.get_node("dragger").hovered = false

		if snap_count != 0:
			rest_point = overlapped_snappers[0].global_position
		rotation_degrees = 0
		get_parent().global_position = lerp(get_parent().global_position, get_global_mouse_position(), 200 * delta)

	elif rest_point != Vector2.ZERO:
		get_parent().global_position = lerp(get_parent().global_position, rest_point, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and hovered and is_top_card:
			selected = true
		else:
			selected = false

func _on_area_2d_body_entered(body: StaticBody2D) -> void:
	if body.dedicated_card == null:
		body.dedicated_card = self
		rest_point = body.global_position
		snapped = true
		body.has_card = true
		overlapped_snappers.append(body)

func _on_area_2d_body_exited(body: StaticBody2D) -> void:
	if body.dedicated_card == self:
		if body.global_position == rest_point:
			rest_point = Vector2.ZERO
		body.dedicated_card = null
		body.has_card = false
		overlapped_snappers.erase(body)
		snapped = false

func _on_area_2d_mouse_entered() -> void:
	hovered = true

func _on_area_2d_mouse_exited() -> void:
	if not selected:
		hovered = false
