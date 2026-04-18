extends CharacterBody2D

@export var speed = 120
@export var gravity = 500
@export var  star_dir = -1
@export var frames : SpriteFrames

var dir : int

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_wall: RayCast2D = $RayWall
@onready var ray_fall: RayCast2D = $RayFall


func _ready() -> void:
	if frames:
		anim.sprite_frames = frames
	anim.play("default")
	dir = star_dir
	
func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = dir * speed
	
	if ray_wall.is_colliding() or !ray_fall.is_colliding():
		turn()
	
	move_and_slide()
	
func turn():
	dir = -dir
	apply_flip()
	
func apply_flip():
	anim.flip_h = (dir > 0)
	var wall_len = 12
	var forward_x = 32
	ray_wall.position = Vector2(forward_x * dir, 12)
	ray_wall.target_position = Vector2(wall_len *dir, 0)
	ray_fall.position.x = abs(ray_fall.position.x) * dir
	
func die():
	var t = create_tween()
	t.tween_property(self, "scale", Vector2(1, 0.2), 0.15)
	await t.finished
	queue_free() 
	
	
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		body.hurt(global_position)
	
