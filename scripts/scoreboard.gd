extends CanvasLayer


func change_score(score: int) -> void:
	$Label.text = "Score: " + str(score)

func _ready() -> void:
	Signalbus.scored_point.connect(change_score)
