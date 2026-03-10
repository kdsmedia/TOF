extends Timer

const INTERVAL = 15
const STATS_INTERVAL = 3
var root

var state = null

const INTRO = 1
const STATS = 2
const NO_DELAY = 3

func _ready():
    connect("timeout", self, "_on_timeout")
    one_shot = true

func _on_timeout():
    if state == INTRO:
        if root.is_intro:
            root.load_menu()

    root.bag.demo_mode.start_map()

    if state == INTRO:
        reset(STATS)
    elif state == STATS:
        reset(INTRO)
    elif state == NO_DELAY:
        reset(INTRO)

    start()

func inject_root(root_obj):
    root = root_obj

func reset(new_state = INTRO):
    state = new_state
    stop()

func start():
    wait_time = __get_interval()
    .start()

func __get_interval():
    if state == INTRO:
        return INTERVAL
    elif state == NO_DELAY:
        return 0
    else: # STATS
        return STATS_INTERVAL
