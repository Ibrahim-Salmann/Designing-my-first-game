extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	# Handle player movement
	player_movement(delta)
	handle_animation()
	
func handle_animation() -> void:
	if velocity.length() > 0:
		if velocity.x > 0:
			$AnimationSprite2D.play("Run")
		elif velocity.x < 0:
			$AnimationSprite2D.play("Run")
		elif velocity.y > 0:
			$AnimationSprite2D.play("Run_back")
		elif velocity.y < 0:
			$AnimationSprite2D.play("Run_front")
	else:
		$AnimationSprite2D.play("Idle")

func player_movement(delta: float) -> void:
	# Get input for horizontal and vertical movement
	var input_vector = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# Normalize the vector to ensure consistent speed in all directions
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	# Set velocity based on input
	velocity = input_vector * SPEED

	# Move the character using move_and_slide()
	move_and_slide()
