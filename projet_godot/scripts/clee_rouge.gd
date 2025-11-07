extends Area2D

@export var key_type: String = "rouge"  # "bleu" ou "rouge"
@onready var NiveauTestNode: Node = get_parent()

func _ready() -> void:
	$CollisionShape2D.disabled = false
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	print("Collision détectée avec :", body.name)  # debug
	if body.is_in_group("player"):
		if key_type == "bleu":
			NiveauTestNode.augmenter_clee_bleu()
		elif key_type == "rouge":
			NiveauTestNode.augmenter_clee_rouge()
		
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		call_deferred("queue_free")
		print("Clé ramassée :", key_type)
