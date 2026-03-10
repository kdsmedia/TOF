func _ready():
    randomize()
    $anim.seek(randf())
    if randf() < 0.5:
        flip_h = true

    $anim.playback_speed = rand_range(0.5, 1.5)
