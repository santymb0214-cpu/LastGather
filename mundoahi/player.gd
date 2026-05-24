class_name Pepe
extends CharacterBody2D

@export var move_speed: float = 200.0
@export var friction: float = 0.2 
@export var acceleration: float = 0.2
# AGREGADO: Aquí está la billetera de Pepe para que la isla pueda leerla
@export var dinero: int = 1000 

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):	
	move_player()
	move_and_slide()
	update_animacion()
	spin()
	
	# Revisa si chocamos con algo en este cuadro (frame)
	for i in get_slide_collision_count():
		var colision = get_slide_collision(i)
		var objeto_chocado = colision.get_collider()
		
		# Si chocamos contra el BloqueoFisico de una isla
		if objeto_chocado.name == "BloqueoFisico":
			# Obtenemos el nodo padre (Isla2) y llamamos a su función de compra
			var nodo_isla = objeto_chocado.get_parent()
			if nodo_isla.has_method("comprar_isla"):
				nodo_isla.comprar_isla(self)

func move_player():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("Move_left", "Move_right")
	input_vector.y = Input.get_axis("Move_up", "Move_down")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * move_speed, move_speed * acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_speed * friction)

func spin():
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

func update_animacion():
	if velocity.length() > 2:
		sprite.play("run")
	else:
		sprite.play("idle")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		GameManager.agregar_monedas(10)
