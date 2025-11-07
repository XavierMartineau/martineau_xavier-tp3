extends Node

@onready var NiveauTestNode: Node = $NiveauTest
@onready var Niveau2Node: Node = $niveau_2

func _ready() -> void:
	# Niveau 1 actif, Niveau 2 désactivé
	set_niveau_active(NiveauTestNode, true)
	set_niveau_active(Niveau2Node, false)

# Active/désactive tous les enfants visuels d’un niveau
func set_niveau_active(niveau: Node, actif: bool) -> void:
	for child in niveau.get_children():
		if child is CanvasItem or child is Node2D:
			child.visible = actif

# Passe du niveau 1 au niveau 2
func passer_au_niveau_2():
	# Désactive tous les enfants du niveau 1
	set_niveau_active(NiveauTestNode, false)

	# Active tous les enfants du niveau 2
	set_niveau_active(Niveau2Node, true)
