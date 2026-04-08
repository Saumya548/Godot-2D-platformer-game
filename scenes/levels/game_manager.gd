extends Node

var ui = null
var hearts = []
var points_label = null
var points = 0
var lives = 3

func _ready():
	await wait_for_ui()
	setup_ui()
	update_hearts()

func wait_for_ui():
	while get_tree().get_first_node_in_group("ui") == null:
		await get_tree().process_frame

func setup_ui():
	ui = get_tree().get_first_node_in_group("ui")
	if ui == null:
		print("UI not found during setup!")
		return

	points_label = ui.get_node_or_null("%PointsLabel")

	var hearts_node = ui.get_node_or_null("%Hearts")
	if hearts_node:
		var box = hearts_node.get_node_or_null("HBoxContainer")
		if box:
			hearts = box.get_children()
			print("Hearts found: ", hearts.size()) # Debug, remove later
	else:
		print("Hearts node not found!") # Debug, remove later

func decrease_health():
	lives -= 1
	print("Lives remaining: ", lives, " | Hearts array size: ", hearts.size())
	update_hearts()
	if lives <= 0:
		game_over()

func update_hearts():
	if hearts.is_empty() or not is_instance_valid(hearts[0]):
		setup_ui()
	if hearts.is_empty():
		print("Hearts still empty after setup_ui!") # Debug, remove later
		return
	for h in range(hearts.size()):
		if is_instance_valid(hearts[h]):
			hearts[h].visible = h < lives

func add_point():
	points += 1
	print("Point added! Total: ", points, " | Instance: ", get_instance_id())
	if points_label == null or not is_instance_valid(points_label):
		setup_ui()
	if points_label:
		points_label.text = "Points : " + str(points)

func game_over():
	print("Final Score: ", points, " | Instance: ", get_instance_id())
	print("Final Score: ", points)
	lives = 3
	points = 0
	clear_ui_refs()
	# Must be deferred — never reload scene directly inside a physics callback
	get_tree().call_deferred("reload_current_scene")

func clear_ui_refs():
	hearts = []
	points_label = null
	ui = null
