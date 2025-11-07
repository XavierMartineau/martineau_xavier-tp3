extends Area2D

class_name Star  # nom de la classe pour pouvoir instancier depuis l’éditeur ou d’autres scripts

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body is Joueur:  # Vérifie que c’est bien le joueur
		print("⭐ Star touchée par le joueur :", body.name)
		
		# Met à jour le HUD
		var hud = get_tree().current_scene.get_node_or_null("HUD")
		if hud:
			hud.ajouter_star()  # Assure-toi que HUD.gd a la méthode ajouter_star()
		else:
			push_warning("HUD introuvable dans la scène !")

		# Supprime ou cache l'étoile après collecte
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		call_deferred("queue_free")
