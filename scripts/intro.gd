extends Control

var root

onready var anim: AnimationPlayer = get_node("anim")
onready var audio: AudioStreamPlayer = get_node("audio")

func _input(event: InputEvent) -> void:
    if (event is InputEventKey and event.pressed) or \
       (event is InputEventMouseButton and event.pressed) or \
       (event is InputEventJoypadButton and event.pressed):
        
        set_process_input(false)

        if not root:
            printerr("Root node not set in intro.gd")
            return

        if root.bag and root.bag.has("demo_mode") and root.bag.demo_mode.has_method("demo_timer"):
            var demo_timer = root.bag.demo_mode.demo_timer
            if demo_timer and not demo_timer.is_stopped():
                demo_timer.stop()

        if root.has_method("unlock_for_demo"):
            root.unlock_for_demo()

        get_tree().create_timer(0.1).connect("timeout", root, "load_menu")

        if event is InputEventJoypadButton:
            if root.bag and root.bag.has("gamepad") and root.bag.gamepad.has_method("mark_gamepad"):
                root.bag.gamepad.mark_gamepad(event)

func init_root(p_root) -> void:
    root = p_root

func _ready() -> void:
    set_process_input(true)
    
    if root and root.settings.get("music_enabled", false):
        audio.play()

func _on_idle_timer_timeout() -> void:
    anim.play("idle")
    if root and root.bag and root.bag.has("demo_mode") and root.bag.demo_mode.has_method("start_demo_mode"):
        root.bag.demo_mode.start_demo_mode()
