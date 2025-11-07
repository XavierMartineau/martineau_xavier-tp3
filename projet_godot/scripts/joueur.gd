extends CharacterBody2D
class_name Joueur

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@export var etat_courant = Etat.REPOS

@export var nombre_coeurs = 0

enum Etat {
	REPOS,
	PROMENER,
	SAUT,
	DEATH
}

func _physics_process(delta):
	if not is_on_floor():
		if is_on_wall() and velocity.y > 0:
			etat_courant = Etat.SAUT
			velocity += get_gravity() * delta
			$AnimatedSprite2D.play("sauter")
		else:
			etat_courant = Etat.SAUT
			velocity += get_gravity() * delta
			$AnimatedSprite2D.play("sauter")
	else:
		if velocity.x == 0:
			etat_courant = Etat.REPOS
			$AnimatedSprite2D.play("repos")
		else:
			etat_courant = Etat.PROMENER
			$AnimatedSprite2D.play("promener")
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true

	# Vérifie collision avec "spike"
	# for i in range(get_slide_collision_count()):
		# var collision = get_slide_collision(i)
		# if collision.get_collider().name == "spike":
			# etat_courant = Etat.DEATH		d
			# dying()
	
	# Handle jump.
	
	if Input.is_action_just_pressed("sauter") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer2Djump.play()
		


		

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("promener_gauche", "promener_droite")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


signal key_collected(key_name)

# Cet dictionnaire peut-être placer sur un 
# objet autoload Main ou GameState
var inventory := {}

func collect_key(key_name: String) -> void:
	inventory[key_name] = true
	key_collected.emit(key_name)

func has_key(key_name: String) -> bool:
	return inventory.get(key_name, false)
