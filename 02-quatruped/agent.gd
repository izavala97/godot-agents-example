extends Node3D

const START_POSITION = Vector3(0, 0.8, 0)
const START_ROTATION = Vector3(0, 0, 0)  # Euler angles in degrees

@onready var ai_controller: Node3D = $AIController3D

@onready var agentBody: RigidBody3D = $AgentBody
@onready var leg1: RigidBody3D = $AgentLeg1
@onready var leg2: RigidBody3D = $AgentLeg2
@onready var leg3: RigidBody3D = $AgentLeg3
@onready var leg4: RigidBody3D = $AgentLeg4

func _ready() -> void:
	pass
	

func _physics_process(_delta: float) -> void:
	leg1.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg1))
	leg2.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg2))
	leg3.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg3))
	leg4.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg4))


func _on_target_body_entered(body: Node3D) -> void:
	reset_rigid_bodies()
	ai_controller.reward += 1.0


func _on_wall_body_entered(_body: Node3D) -> void:
	reset_sim()
	
func _on_floor_area_body_entered(body: Node3D) -> void:
	if body.name == agentBody.name:
		reset_sim()
		

func reset_sim() -> void:
	ai_controller.reward -= 1.0
	reset_rigid_bodies()
	ai_controller.reset()


func reset_rigid_bodies() -> void:
	# Disable physics interaction
	agentBody.freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
	leg1.freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
	leg2.freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
	leg3.freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
	leg4.freeze_mode = RigidBody3D.FREEZE_MODE_STATIC

	# Reset positions and rotations
	agentBody.global_transform.origin = START_POSITION
	agentBody.rotation_degrees = START_ROTATION

	leg1.global_transform = Transform3D(Basis(), agentBody.global_transform.origin)
	leg1.rotation_degrees = START_ROTATION
	
	leg2.global_transform = Transform3D(Basis(), agentBody.global_transform.origin)
	leg2.rotation_degrees = START_ROTATION
	
	leg3.global_transform = Transform3D(Basis(), agentBody.global_transform.origin)
	leg3.rotation_degrees = START_ROTATION
	
	leg4.global_transform = Transform3D(Basis(), agentBody.global_transform.origin)
	leg4.rotation_degrees = START_ROTATION

	# Re-enable physics interaction
	agentBody.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	leg1.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	leg2.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	leg3.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	leg4.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	print("reset body")
	await get_tree().create_timer(2).timeout
