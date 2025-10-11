extends Node2D
var hand_target_pos
var snapper_target_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_target_pos = $Hand.global_position + Vector2(0, 250)
	snapper_target_pos = $AllSnappers.global_position + Vector2(0, 250)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Assuming delta2 is your frame delta
func begin_animations(delta) -> void:
	#$Hand.global_position = lerp($Hand.global_position, hand_target_pos, 20 * delta2)
	$Hand.global_position = $Hand.global_position.move_toward(hand_target_pos, 2000 * delta)
	$AllSnappers.global_position = $AllSnappers.global_position.move_toward(snapper_target_pos, 2000 * delta)
	#$AllSnappers.global_position = lerp($AllSnappers.global_position, snapper_target_pos, 20 * delta2)
	print($Hand.global_position)
