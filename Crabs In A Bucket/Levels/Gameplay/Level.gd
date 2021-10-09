extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crab
var crabForm = preload("res://Objects/SpikeCrabPlatform.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	crab = get_node("Crab")
	crab.connect("crabDeath", self, "_on_crab_death")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_crab_death():
	var instance = crabForm.instance()
	add_child(instance)
	instance.position = crab.position
	


