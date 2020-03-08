extends KinematicBody2D

const GRAVITY = 35

var speed = 350
var direction = Vector2()
var movement = Vector2()
var jump_strength = 900
var life = 100
var mana = 100

var current_state = "idle"

func _physics_process(delta):
	if mana < 100:
		mana += delta*20
	
	if current_state != "attacking" and current_state != "hit":
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
			$Attack.scale.x = -1
			current_state = "moving"
		elif Input.is_action_pressed("ui_right"):
			direction.x = 1
			$Attack.scale.x = 1
			current_state = "moving"
		else:
			direction.x = 0
			current_state = "idle"
		
		movement.x = speed*direction.x
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				movement.y = -jump_strength
			else:
				movement.y = 0
		else:
			movement.y += GRAVITY
		
		movement = move_and_slide(movement, Vector2.UP)
	
	if current_state == "hit":
		move_and_slide(direction *300)
	
	elif $AnimationPlayer.is_playing() == false:
		current_state = "idle"
		$Attack/AttackArea/CollisionPolygon2D.disabled = true
		if Input.is_action_just_pressed("attack") and mana >= 33:
			$Attack/AttackArea/CollisionPolygon2D.disabled = false
			$AnimationPlayer.play("Attack")
			current_state = "attacking"
			mana -= 33


func damage(damage_amount, damage_position):
	if current_state != "hit":
		direction = (global_position - damage_position ).normalized()
		current_state = "hit"
		$TimerDamage.start(0.15)


func _on_TimerDamage_timeout():
	current_state = "idle"

