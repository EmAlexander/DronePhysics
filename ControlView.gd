extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = Vector2((Input.get_action_strength("Backward") - Input.get_action_strength("Forward")), (Input.get_action_strength("Right") - Input.get_action_strength("Left")))
	var elevation = Input.get_action_strength("Down") - Input.get_action_strength("Lift")
	var roll = Input.get_action_strength("RollRight") - Input.get_action_strength("RollLeft")
	
	$LeftStickLimits/LeftStickAxis.position.y = elevation * 50
	$RightStickLimits/RightStickAxis.position.x = move.y * 50
	$RightStickLimits/RightStickAxis.position.y = move.x * 50