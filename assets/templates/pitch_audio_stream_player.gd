extends AudioStreamPlayer

var pitch_low = .8
var pitch_hi = 1.2
var lastPitch = 1
var pitch_min_diff = .1
var using_timer = false
var can_play = false

#func _ready() -> void:
	#$Timer.timeout.connect(_on_timer_timeout)

func init(low=.8,high=1.2,diff=.1,timeout=1.0) -> void:
	set_pitches(low,high,diff)
	set_timeout(1.0)
	

func set_timeout(time):
	using_timer = true
	can_play = true
	$Timer.wait_time = time

func play_pitched(from_position=0.0):
	while abs(lastPitch - pitch_scale) < pitch_min_diff:
		pitch_scale = randf_range(pitch_low, pitch_hi)
	lastPitch = pitch_scale
	if not playing and (not using_timer or can_play):
		play(from_position)
		can_play = false
		$Timer.start()

func set_pitches(low=.8,high=1.2,diff=.1):
	pitch_low = low
	pitch_hi = high
	pitch_min_diff = diff


func _on_timer_timeout() -> void:
	can_play = true
