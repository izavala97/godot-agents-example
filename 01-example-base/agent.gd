extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const START_POSITION = Vector3(0,0.8,0);

@onready var ai_controller: Node3D = $AIController3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = ai_controller.move.x
	velocity.z = ai_controller.move.y

	move_and_slide()


func _on_target_body_entered(_body: Node3D) -> void:
	position = START_POSITION
	ai_controller.reward += 1.0


func _on_wall_body_entered(_body: Node3D) -> void:
	position = START_POSITION
	ai_controller.reward -= 1.0
	ai_controller.reset()
