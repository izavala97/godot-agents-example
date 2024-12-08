extends AIController3D

var r_leg1 = 0.0
var r_leg2 = 0.0
var r_leg3 = 0.0
var r_leg4 = 0.0

@onready var agent: Node3D = $".."
@onready var leg1: Node3D = $"../AgentLeg1"
@onready var leg2: Node3D = $"../AgentLeg2"
@onready var leg3: Node3D = $"../AgentLeg3"
@onready var leg4: Node3D = $"../AgentLeg4"

@onready var target: Area3D = $"../../Target"

func get_obs() -> Dictionary:
	var obs := [
		agent.position.x,
		agent.position.y,
		agent.position.z,
		agent.rotation_degrees.x,
		agent.rotation_degrees.y,
		agent.rotation_degrees.z,
		leg1.rotation.z,
		leg2.rotation.z,
		leg3.rotation.z,
		leg4.rotation.z,
		target.position.x,
		target.position.y,
		target.position.z
	]
	return {"obs": obs}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"rotate" : {
			"size": 4,
			"action_type": "continuous"
		},
	}
	
func set_action(action) -> void:	
	r_leg1 = action["rotate"][0]
	r_leg2 = action["rotate"][1]
	r_leg3 = action["rotate"][2]
	r_leg4 = action["rotate"][3]
