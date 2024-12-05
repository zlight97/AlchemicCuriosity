extends CanvasLayer

signal done_fading

var fading = false

func start(time: float) -> void:
	get_tree().paused = true
	$Timer.wait_time = time
	fading = true

func _process(delta) -> void:
	if fading:
		$Polygon2D.set_color(lerp($Polygon2D.get_color(), Color(0,0,0,1), (3/$Timer.wait_time) * delta*2))
		if $Timer.is_stopped():
			$Timer.start()

func stop() -> void:
	done_fading.emit()
	$Polygon2D.set_color(Color(0,0,0,0))
	fading = false
	get_tree().paused = false
