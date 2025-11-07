extends Area2D

@onready var NiveauTestNode = get_parent()  # doit être enfant direct de NiveauTest

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	print("Collision détectée avec :", body.name)
	if body.is_in_group("player"):
		print("✅ Player détecté")
		NiveauTestNode.augmenter_clee_bleu()
		$CollisionShape2D.set_deferred("disabled", true)
		hide()
		call_deferred("queue_free")
