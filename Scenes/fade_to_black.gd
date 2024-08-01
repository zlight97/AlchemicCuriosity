extends CanvasLayer

signal done_fading

var fading = false

func start():
	fading = true

func _process(delta):
	if fading:
		$Polygon2D.set_color(lerp($Polygon2D.get_color(), Color(0,0,0,1), 0.05))
		if $Timer.is_stopped():
			$Timer.start()

func stop():
	done_fading.emit()
	$Polygon2D.set_color(Color(1,0,0,0))
	fading = false
