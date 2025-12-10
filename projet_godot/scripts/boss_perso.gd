extends CharacterBody2D
class_name Boss 

# --- CONFIGURATION PRELOAD ---
const PROJECTILE_ENEMIE = preload("res://Scenes/projectile_enemie.tscn") 

# --- GESTION DE LA VIE ---
const MAX_HEALTH = 300 
var current_health = MAX_HEALTH
var is_dead: bool = false
var is_activated: bool = true        

# --- CONFIGURATION STATIQUE ---
const GRAVITY = 800.0
const ATTACK_RATE = 1.5       
var cooldown_restant: float = 0.0     

# --- RÉFÉRENCES AUX NŒUDS ---
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var launch_point: Node2D = $LauncherPoint 

# CHEMIN DE RÉFÉRENCE CORRECT : Le HUD est un enfant du nœud racine 'BOSS'
# Nous utilisons get_node pour trouver le Label dans le HUD
@onready var health_label: Label = get_tree().root.get_node("BOSS/HUD/HBoxContainer/label_boss") 


func _ready() -> void:
	current_health = MAX_HEALTH
	if animated_sprite:
		animated_sprite.animation_finished.connect(_on_animation_finished)
		animated_sprite.play("Idle")
	
	update_health_display()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	velocity.x = 0
	move_and_slide()


func _process(delta: float) -> void:
	if is_dead: return

	cooldown_restant -= delta
		
	if cooldown_restant <= 0:
		start_attack_cycle() 
		cooldown_restant = ATTACK_RATE 
	
# --- LOGIQUE D'ATTAQUE ---

func start_attack_cycle():
	animated_sprite.play("atack")
	perform_projectile_launch()
	
func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "atack":
		animated_sprite.play("Idle") 
	
func perform_projectile_launch():
	if not PROJECTILE_ENEMIE: return
		
	var projectile = PROJECTILE_ENEMIE.instantiate()
	# Le projectile est instancié à la racine du Boss (groupe_boss)
	get_parent().add_child(projectile) 
	projectile.global_position = launch_point.global_position
	
	var direction = 1.0 
	if animated_sprite and animated_sprite.flip_h:
		direction = -1.0
		
	if projectile.has_method("initialiser"):
		# Le projectile ennemi inflige 10 dégâts (géré dans projectile_enemie.gd)
		projectile.initialiser(direction) 


# --- LOGIQUE DE VIE ET DÉGÂTS ---

func prendre_degats(amount: int):
	if is_dead: return
	
	current_health = max(0, current_health - amount)
	update_health_display()
	
	if current_health <= 0:
		die()

func update_health_display():
	# Mise à jour du texte du Label 'label_boss'
	if is_instance_valid(health_label):
		health_label.text = str(current_health)


func die():
	if is_dead: return
	
	is_dead = true
	print("Le Boss est vaincu!")
	
	# Ajouter ici l'animation de mort du Boss si vous en avez une
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
