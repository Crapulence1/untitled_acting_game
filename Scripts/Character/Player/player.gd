extends Character

@export var total_deck : Array
@export var player_area : Node2D
var discard_pile : Array
var draw_pile : Array
var is_turn_played : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_turn_played:
		player_area.begin_animations(delta)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			is_turn_played = true

func take_turn() -> void:
	print("dwa")
	player_area.begin_animations()
	pass
