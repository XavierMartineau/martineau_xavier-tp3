extends CanvasLayer
class_name HUD  # permet de l'identifier et de l'instancier facilement

# Labels
@onready var label_stars = $HBoxContainer/label_stars
@onready var label_ruby = $HBoxContainer/label_ruby

# Compteurs
var nb_stars: int = 0  # étoiles
var nb_ruby: int = 0   # rubis

func _ready() -> void:
	# Initialise l'affichage au démarrage
	label_stars.text = str(nb_stars)
	label_ruby.text = str(nb_ruby)

# Méthode pour ajouter une étoile
func ajouter_star() -> void:
	nb_stars += 1
	label_stars.text = str(nb_stars)
	print("HUD : étoiles =", nb_stars)

# Méthode pour ajouter un rubis
func ajouter_ruby() -> void:
	nb_ruby += 1
	label_ruby.text = str(nb_ruby)
	print("HUD : rubis =", nb_ruby)
