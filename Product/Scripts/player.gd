extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	# Handle player movement
	player_movement(delta)
	#handle_animation()
	
func player_movement(_delta: float) -> void:
	# Get input for horizontal and vertical movement
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	print(input_vector)

	# Normalize the vector to ensure consistent speed in all directions
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	# Set velocity based on input
	velocity = input_vector * SPEED

	# Move the character using move_and_slide()
	move_and_slide()
	
#func handle_animation() -> void:
	## Handle animation based on velocity
	#if velocity.length() > 0:
		#if velocity.x > 0:
			#$AnimationSprite2D.play("Run_right")
		#elif velocity.x < 0:
			#$AnimationSprite2D.play("Run_left")
		#elif velocity.y > 0:
			#$AnimationSprite2D.play("Run_down")
		#elif velocity.y < 0:
			#$AnimationSprite2D.play("Run_up")
	#else:
		## Play idle animation based on direction
		#if velocity.x > 0:
			#$AnimationSprite2D.play("Idle_right")
		#elif velocity.x < 0:
			#$AnimationSprite2D.play("Idle_left")
		#elif velocity.y > 0:
			#$AnimationSprite2D.play("Idle_down")
		#elif velocity.y < 0:
			#$AnimationSprite2D.play("Idle_up")
