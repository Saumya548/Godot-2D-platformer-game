extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		GameManager.decrease_health()
		
		# Respawn the character at the spawn point
		var spawn = get_tree().get_first_node_in_group("spawn_point")
		if spawn:
			body.global_position = spawn.global_position
			body.velocity = Vector2.ZERO  # Stop any falling momentum
		else:
			print("Spawn point not found!")
