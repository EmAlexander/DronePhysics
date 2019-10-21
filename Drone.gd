extends RigidBody

export (bool) var auto_roll := true
export (float) var pitch_sensitivity := 1.0
export (float) var yaw_sensitivty := 2.5
export (float) var roll_sensitivty := 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var upward_force = 0.0;
var desired_rotation = Vector3(0, 0, 0)

func _integrate_forces(state):
	var diff = rotation - desired_rotation
	
	rotation += lerp(diff, rotation, 0.25)
	
	#if auto_roll:
	#	global_rotate(Vector3(0, 0, 1), lerp(global_transform.basis.get_euler().z - desired_rotation.z, 0, 1))

func _input(event):
	if event.is_action_pressed("switchcams"):
		$Camera.current = !$Camera.current

func _process(delta):
	var forces = Vector3(0, 0, 0)
	var applied_torque = Vector3(0, 0, 0)
	
	var move = Vector2((Input.get_action_strength("Forward") - Input.get_action_strength("Backward")), (Input.get_action_strength("Right") - Input.get_action_strength("Left")))
	var elevation = Input.get_action_strength("Lift") - Input.get_action_strength("Down")
	var roll = Input.get_action_strength("RollRight") - Input.get_action_strength("RollLeft")
	
	if Input.is_action_pressed("FullStop"):
		upward_force = 0
	
	if auto_roll:
		desired_rotation.z += roll * delta * roll_sensitivty
	else:
		desired_rotation.z = 0
	
	upward_force = elevation * 15
	
	desired_rotation.y += move.y * delta * yaw_sensitivty
	desired_rotation.x += move.x * delta * pitch_sensitivity
	
	upward_force = clamp(upward_force, 0.0, 50)
	forces.y += upward_force
	forces = transform.basis.xform(forces)
	
	add_force(forces, Vector3(0, 0, 0))