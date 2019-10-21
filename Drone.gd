extends RigidBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var upward_force = 0.0;

func _process(delta):
	var forces = Vector3(0, 0, 0)
	var applied_torque = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("Lift"):
		upward_force += 0.05
		
	if Input.is_action_pressed("Down"):
		upward_force -= 0.05
	
	if Input.is_action_pressed("Forward"):
		applied_torque.x -= 0.001
	
	if Input.is_action_pressed("Backward"):
		applied_torque.x += 0.001
	
	if Input.is_action_pressed("Left"):
		applied_torque.y += 0.001
	
	if Input.is_action_pressed("Right"):
		applied_torque.y -= 0.001
	
	if Input.is_action_pressed("RollLeft"):
		applied_torque.z += 0.001
	
	if Input.is_action_pressed("RollRight"):
		applied_torque.z -= 0.001
	
	if Input.is_action_pressed("FullStop"):
		upward_force = 0
	
	upward_force = clamp(upward_force, 0.0, 50)
	forces.y += upward_force
	forces = transform.basis.xform(forces)
	applied_torque = transform.basis.xform(applied_torque)
	
	print(applied_torque)
	
	add_force(forces, Vector3(0, 0, 0))
	#add_torque(applied_torque)
	apply_torque_impulse(applied_torque)
	
	print(upward_force)