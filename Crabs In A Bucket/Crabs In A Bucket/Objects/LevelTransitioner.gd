extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player"):
		Global.level += 1
		get_tree().change_scene("res://Levels/Gameplay/Level_" + str(Global.level) + ".tscn")
