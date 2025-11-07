extends Area2D
class_name FinalLock

@onready var hud = get_tree().current_scene.get_node_or_null("HUD")

func _ready() -> void:
	if not hud:
		push_warning("HUD introuvable ! Le FinalLock ne pourra pas vérifier les conditions.")
		return

	# Vérifie immédiatement si la condition est déjà remplie
	_check_conditions()

	# Connecte aux signaux pour que le lock réagisse aux changements
	hud.connect("star_added", Callable(self, "_check_conditions"))
	hud.connect("ruby_added", Callable(self, "_check_conditions"))

func _check_conditions() -> void:
	if hud.nb_ruby >= 1 and hud.nb_stars >= 12:
		disparaitre()

func disparaitre() -> void:
	print("🔓 FinalLock débloqué !")
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.finished.connect(Callable(self, "queue_free"))
