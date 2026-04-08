extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var game_manager = get_tree().get_first_node_in_group("game_manager")

var collected := false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D" and not collected:
		collected = true
		
		animated_sprite_2d.scale = Vector2(1.2, 1.2)
		$CollisionShape2D.set_deferred("disabled", true)
		animated_sprite_2d.animation = "collected"
		
		await animated_sprite_2d.animation_finished
		
		if GameManager:
			GameManager.add_point()

		queue_free()
