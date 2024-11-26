extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	# Handle player movement
	player_movement(delta)
	#handle_animation()
	
func player_movement(delta: float) -> void:
	# Get input for horizontal and vertical movement
	var input_vector = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	# Normalize the vector to ensure consistent speed in all directions
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	# Set velocity based on input
	velocity = input_vector * SPEED

	# Move the character using move_and_slide()
	move_and_slide()
	
#func handle_animation() -> void:
	#if velocity.length() > 0:
		#if velocity.x > 0:
			#$AnimationSprite2D.play("Run_left")
		#elif velocity.x < 0:
			#$AnimationSprite2D.play("Run_right")
		#elif velocity.y > 0:
			#$AnimationSprite2D.play("Run_down")
		#elif velocity.y < 0:
			#$AnimationSprite2D.play("Run_up")
	#else:
		#$AnimationSprite2D.play("Idle")
