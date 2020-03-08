extends Area2D

var direction = Vector2()
var speed = 200

func _physics_process(delta):
	global_position.x += direction.x*speed*delta



func _on_Spell_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(3, global_position)
		queue_free()
	pass # Replace with function body.
