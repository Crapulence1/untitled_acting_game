extends Node2D
var cardsInHand : Array =[]
var defaultRadius : int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InputHandler.handRef = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	addCardsToArray()
	updateHandLayout(delta)
	
	pass

var angleOne : int = -80 # left hand angle
var angleTwo : int = 80 # right hand angle



func updateHandLayout(delta):
	if len(cardsInHand) == 0:
		return
	
	var cardRadius = defaultRadius

	# If only one card, center it
	if len(cardsInHand) == 1:
		var card = cardsInHand[0]
		if card.isTopCard:
			cardRadius+=10
			card.z_index = 100
		else:
			card.z_index = card.handIndex
		var angle_deg = 0
		var angle_rad = deg_to_rad(angle_deg)
		var x = cardRadius * sin(angle_rad)
		var y = -cardRadius * cos(angle_rad)
		card.latestSetPosition = Vector2(x, y)
		card.rotation_degrees = 0
		return

	# For 2+ cards → evenly spaced and centered
	var angleStep : float = (angleTwo - angleOne) / float(len(cardsInHand) - 1)
	var startAngle : float = angleOne

	for i in range(len(cardsInHand)):
		cardRadius = defaultRadius
		cardsInHand[i].handIndex = i
		var card : Node2D = cardsInHand[i]
		if card.isTopCard:
			cardRadius+=10
			card.z_index = 100
		else:
			card.z_index = card.handIndex
			pass
		var angle_deg : float = startAngle + i * angleStep
		var angle_rad : float = deg_to_rad(angle_deg)

		# Polar → Cartesian
		var x : float = cardRadius * sin(angle_rad)
		var y : float = -cardRadius * cos(angle_rad)

		# Smooth motion
		card.latestSetPosition = Vector2(x, y)
		card.rotation_degrees = angle_deg * 0.3


func addCardsToArray():
	cardsInHand = []
	for child in get_children():
		if child.is_in_group("handCards") and not child.is_in_group("slottedCards"): 
			cardsInHand.append(child)
	

func _on_initial_mouse_entered() -> void:
	defaultRadius = 100
	$initial.monitoring = false
	$initial.input_pickable = false
	$initial.visible = false

	$final.monitoring = true
	$final.input_pickable = true
	$final.visible = true


func _on_final_mouse_exited() -> void:
	defaultRadius = 50
	$final.visible = false
	$final.monitoring = false
	$final.input_pickable = false

	$initial.visible = true
	$initial.monitoring = true
	$initial.input_pickable = true
