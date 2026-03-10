extends Sprite

export var damaged = false
var max_frames

func _ready():
    randomize()
    max_frames = vframes * hframes
    check_destruction()

func check_destruction():
    if damaged:
        frame = randi() % max_frames
    else:
        frame = 0

func set_damage():
    damaged = true
