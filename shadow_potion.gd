extends thrown_potion

@onready var player = get_node("/root/SceneManager").player

func _ready():
	$AnimatedSprite2D.sprite_frames = load("res://assets/images/potion/purple/shadow_potion.tres")

func splash_ground():
	player.shadow_loc = position
