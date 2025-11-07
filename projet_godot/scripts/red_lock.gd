extends StaticBody2D

@onready var NiveauTestNode: Node = get_parent()

func _ready() -> void:
	if NiveauTestNode.has_signal("clee_rouge_change"):
		NiveauTestNode.connect("clee_rouge_change", Callable(self, "_check_unlock"))

func _check_unlock(valeur: int) -> void:
	if valeur >= 1:
		debloquer()

func debloquer() -> void:
	print("Red lock débloqué !")
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.finished.connect(Callable(self, "queue_free"))
