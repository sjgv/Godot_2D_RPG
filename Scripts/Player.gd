extends CharacterBody2D
# Physics
@export var speed = 50
@onready var animation_sprite = %PlayerAnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# So diagonals aren't faster
	if abs(direction.x) ==1 and abs(direction.y) == 1:
		direction = direction.normalized()
		
	var movement = speed * direction * delta
	move_and_collide(movement)
	player_animation(direction)
# Player Animations 
func player_animation(direction: Vector2):
	"""
	Plays the animation corresponding to the input movement
	"""
	var animation_name: String
	if direction != Vector2.ZERO:
		direction = direction
		animation_name = "walk_" + return_direction(direction)
	else:
		animation_name = "idle_" + return_direction(direction)
	animation_sprite.play(animation_name)
		
func return_direction(direction: Vector2):
	"""
	Returns the suffix of the animation to play
	"""
	var normalized_direction = direction.normalized()
	var default_return = "side"
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		animation_sprite.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		animation_sprite.flip_h = true
		return "side"
	
	return default_return
