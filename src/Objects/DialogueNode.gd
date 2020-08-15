extends Area2D

var can_talk = true
var talking_person = null
var actors = ["actor_1", "actor_2", "actor_3", "actor_4", "actor_player",]
var actions = ["play_animation", "set_animation", "end_dialogue"]
var execute_action = null
var dialogue_line_number = 0
var dialogue_start = false
var animation_name : String

export (Color) var actor_1_text_color
export (Color) var actor_2_text_color
export (Color) var actor_3_text_color
export (Color) var actor_4_text_color

export (NodePath) var actor_1
export (NodePath) var actor_2
export (NodePath) var actor_3
export (NodePath) var actor_4
export (NodePath) var actor_player

export (Array, String) var dialogue_lines

export (bool) var active = true
export (bool) var auto = false

# Removes the node from the scene completely upon end of dialogue
export (bool) var autoDisable = true

onready var player = get_node("../Player")
onready var player_text = get_node("../Player/Interact/PlayerTalk")
#onready var director = get_node("../director")
onready var player_animation = get_node("../Player/Skin/AnimationPlayer")

signal line_finished

func _ready():
	print("Dialogue Ready")
	if active == true:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true

func _on_dialogue_node_area_entered(area):
	dialogue_start = true
	player_text.show()
	if auto:
		if can_talk:
			$dialogue_placer/text_box.show()
			$dialogue_placer/next.hide()
			player.talking = true
			player.hook.is_active = false
			$dialogue_placer/speaker_name.show()
			dialogue()
		else:
			return


func _on_dialogue_node_area_exited(area):
	dialogue_start = false
	player_text.hide()

func _unhandled_input(event: InputEvent) -> void:
	if dialogue_start:
		if (event.is_action_pressed("interact")):
			if can_talk:
				$dialogue_placer/text_box.show()
				$dialogue_placer/next.hide()
				player.talking = true
				player.hook.is_active = false
				$dialogue_placer/speaker_name.show()
				dialogue()
			else:
				return
	else:
		return


func dialogue():
	can_talk = false
	$dialogue_placer/text.visible_characters = 0
	$dialogue_placer/text.text = dialogue_lines[dialogue_line_number]
	
	if dialogue_lines[dialogue_line_number] in actors:
		talking_person = dialogue_lines[dialogue_line_number]
		
		match talking_person:
			
			"actor_1":
				talking_person = actor_1
				$dialogue_placer/text.set("custom_colors/font_color", actor_1_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_1_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_person).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_2":
				talking_person = actor_2
				$dialogue_placer/text.set("custom_colors/font_color", actor_2_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_2_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_person).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_3":
				talking_person = actor_3
				$dialogue_placer/text.set("custom_colors/font_color", actor_3_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_3_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_person).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_4":
				talking_person = actor_4
				$dialogue_placer/text.set("custom_colors/font_color", actor_4_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_4_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_person).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_player":
				talking_person = actor_player
				$dialogue_placer/text.set("custom_colors/font_color", Color("#ffffff"))
				$dialogue_placer/speaker_name.set("custom_colors/font_color", Color("#ffffff"))
				$dialogue_placer/speaker_name.text = "Alwin"
				dialogue_line_number += 1
				dialogue()
				return
	else:
		pass
	
	
	if dialogue_lines[dialogue_line_number] in actions:
		execute_action = dialogue_lines[dialogue_line_number]
		
		match execute_action:
			
			"play_animation":
				
				$dialogue_placer/text_timer.stop()
				$dialogue_placer/speaker_name.hide()
				$dialogue_placer/text_box.hide()
				
				var a = get_node(str(talking_person) + "/Skin/AnimationPlayer")
				
				a.play(animation_name)
				yield(a, "animation_finished")
				dialogue_line_number += 1
				$dialogue_placer/text_box.show()
				$dialogue_placer/speaker_name.show()
				dialogue()
				return
			
			"set_animation":
				animation_name = dialogue_lines[dialogue_line_number +1]
				dialogue_line_number += 2
				dialogue()
				return
			
			"end_dialogue":
				
				$dialogue_placer/text_timer.stop()
				$dialogue_placer/speaker_name.hide()
				$dialogue_placer/text_box.hide()
				#director.zoom(Vector2(0.6, 0.6), 1.0)
				player.talking = false
				player.hook.is_active = true
				if autoDisable:
					# Removes the Dialogue Node from the Scene
					queue_free()
	else:
		pass
	
	
	
	$dialogue_placer/text_timer.start()
	yield(self, "line_finished")
	dialogue_line_number += 1
	can_talk = true



func _on_text_timer_timeout():
	if $dialogue_placer/text.percent_visible != 1:
		$dialogue_placer/text.visible_characters += 1
	else:
		emit_signal("line_finished")
		$dialogue_placer/next.show()
