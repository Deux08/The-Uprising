extends Area2D

var talking = false
var areas_entered = []

func show_look_hint():
	$hank_timer.start()

func _on_hank_timer_timeout():
	if $hank_text.percent_visible != 1:
		$hank_text.visible_characters += 1
	else:
		$hank_timer.stop()
		yield(get_tree().create_timer(2), "timeout")
		$hank_text.percent_visible = 0
		$hank_text.visible_characters = 0

func _on_Interact_area_entered(area):
	pass # Replace with function body.


func _on_PlayerTimer_timeout():
	pass # Replace with function body.
