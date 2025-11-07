extends StaticBody2D

@onready var NiveauTestNode = get_parent()  # parent = NiveauTest

func _ready() -> void:
	if NiveauTestNode.has_signal("clee_bleu_change"):
		NiveauTestNode.connect("clee_bleu_change", Callable(self, "_on_clee_bleu_change"))
		print("BlueLock connecté au signal")
	else:
		push_warning("Signal 'clee_bleu_change' introuvable sur NiveauTestNode")

func _on_clee_bleu_change(valeur: int) -> void:
	if valeur >= 1:
		debloquer()

func debloquer() -> void:
	print("🔓 BlueLock disparu !")
	# Animation de disparition (optionnel)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.finished.connect(Callable(self, "queue_free"))  # supprime l'objet après l'animation
