extends Sprite

enum PlayerColor { BLUE, RED, WHITE }
export (PlayerColor) var color = PlayerColor.WHITE setget set_color

onready var anim: AnimationPlayer = get_node("anim")

func _ready() -> void:
	randomize()
	self.color = color # Set initial color

func set_color(new_color: int) -> void:
	color = new_color
	var animation_name: String
	match color:
		PlayerColor.BLUE: # blue
			animation_name = "blue"
		PlayerColor.RED: # red
			animation_name = "red"
		_: # white
			animation_name = "white"

	if anim and anim.has_animation(animation_name):
		anim.play(animation_name)
		if anim.current_animation:
			var animation = anim.get_animation(anim.current_animation)
			if animation:
				anim.seek(randf() * animation.length, true)

func change_flag(player_id: int):
	# player_id: -1 for neutral, 0 for blue, 1 for red
	if player_id == 0:
		set_color(PlayerColor.BLUE)
	elif player_id == 1:
		set_color(PlayerColor.RED)
	else:
		set_color(PlayerColor.WHITE)
