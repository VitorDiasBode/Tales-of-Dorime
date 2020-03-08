extends StaticBody2D

var player = null

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down") and player != null:
		$CollisionPolygon2D.disabled = true
		$Timer.start(0.2)


func _on_Timer_timeout():
	$CollisionPolygon2D.disabled = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player = null
