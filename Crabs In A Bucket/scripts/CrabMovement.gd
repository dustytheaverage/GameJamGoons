extends KinematicBody2D


# Declare member variables here. Examples:
var speed = 200
var canJump = true
const JUMP_FORCE = 250
const GRAVITY = 400
var currentGravity = GRAVITY
var dying = false
var startPosition
var velocity = Vector2()

signal crabDeath

onready var sprite = get_node("AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	startPosition = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += currentGravity * delta # account for gravity
	if !dying:
		_movement_inputs() # get left-right movement input
	
	velocity = move_and_slide(velocity, Vector2(0, -1)) #move according to velocity and get collisions for the tick
	
	canJump = is_on_floor() # allow jumping if on floor
	
	# check each collision for the tick and see if any are a death trigger
	for i in get_slide_count(): 
		var collision = get_slide_collision(i)
		
	
	
	

func _movement_inputs():
	var moveDir = -int(Input.is_action_pressed("Left")) + int(Input.is_action_pressed("Right")) # read L-R input
	velocity.x = lerp(velocity.x, moveDir * speed, 0.2) # interpolate towards the right direction to make it feel nice.
	if abs(velocity.x) > 0.5 and canJump == true:
		sprite.play("Move")
	elif canJump == true:
		sprite.play("Idle")
	else:
		sprite.play("Jump")

func _input(event):
	if event.is_action_pressed("Jump") and canJump and !dying:
		velocity.y = -JUMP_FORCE
		
	if event.is_action_pressed("Reset"):
		get_tree().change_scene("res://Levels/Gameplay/Level_" + str(Global.level) + ".tscn")


func _grapple():
	pass
	
func _release():
	pass


func _on_Area2D_body_entered(body):
	if body.get_collision_layer() == 2:
		dying = true
		sprite.play("SpikeDeath")
		currentGravity = 0
		velocity = Vector2(0, 0)
	


func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "SpikeDeath":
		emit_signal("crabDeath")
		sprite.play("Idle")
		dying = false
		currentGravity = GRAVITY
		position = startPosition
	
