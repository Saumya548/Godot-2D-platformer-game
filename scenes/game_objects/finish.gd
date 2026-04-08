extends Area2D
@export var target_level : PackedScene
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if  (body.name == "CharacterBody2D"):
		
		sprite_2d.animation = "finished"
		
		await sprite_2d.animation_finished
		
		get_tree().change_scene_to_packed(target_level)
