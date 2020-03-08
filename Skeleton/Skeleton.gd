extends KinematicBody2D

const GRAVITY = 35

var speed = 75
var direction = Vector2()
var movement = Vector2()
var life = 15
var player = null
var active = false

func _physics_process(delta):
	if active == true:
		if player != null:
			direction = (player.global_position - global_position).normalized() 
		
		movement.x = direction.x*speed
	if is_on_floor() == false:
		movement.y += GRAVITY
	else:
		movement.y = 0
	move_and_slide(movement, Vector2.UP)
	

func _on_Area_Vision_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		active = true

func _on_Area_Vision_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		active = false
	pass # Replace with function body.


func _on_AttackArea_area_entered(area):
	if area.is_in_group("Attack"):
		life -= 8
		if life <= 0:
			queue_free()


func _on_AttackArea_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(14, global_position)
		active = false
		$TimerAttack.start(0.3)
		


func _on_TimerAttack_timeout():
	active = true
