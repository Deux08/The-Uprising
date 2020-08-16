extends Node2D

func _on_FinalDialogue_dialogue_finished():
	SceneChanger.change_scene("res://src/Main/MainMenu.tscn")
