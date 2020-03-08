extends Area2D

var life = 15
var load_spell = load("res://Mage/Spell/Spell.tscn")
var player = null
var look_direction = Vector2()

func _physics_process(delta):
	if player != null:
		look_direction = (player.global_position - global_position).normalized()
		if global_position.x > player.global_position.x:
			$SpawPoint.position.x = -40
		else:
			$SpawPoint.position.x = 40
		
		if $SpawnTimer.is_stopped():
			$SpawnTimer.start(3)
			pass


func _on_AreaVision_body_entered(body):
	if body.is_in_group("Player"):
		player = body
	pass # Replace with function body.


func _on_AreaVision_body_exited(body):
	if body.is_in_group("Player"):
		player = null


func _on_Mage_area_entered(area):
	if area.is_in_group("Attack"):
		life -= 5
		if life <= 0:
			queue_free()


func _on_SpawnTimer_timeout():
	var speell = load_spell.instance()
	add_child(speell)
	speell.direction = look_direction
	speell.global_position = $SpawPoint.global_position


func _on_Mage_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(3, global_position)
	pass # Replace with function body.
