extends Node2D

# Configura el precio desde el Inspector a la derecha
@export var precio_isla: int = 500

# Referencias directas a tus nodos actuales
@onready var mapa_tierra = $frontgroud
@onready var muro_fisico = $BloqueoFisico

var comprada: bool = false

func _ready():
	# Al iniciar el juego, la isla se oculta (mostrando el agua de fondo)
	actualizar_isla()

func actualizar_isla():
	if not comprada:
		mapa_tierra.visible = false  # Oculta la tierra; se ve el agua de abajo
		muro_fisico.visible = true   # El muro se queda activo
	else:
		mapa_tierra.visible = true   # ¡Aparece la isla verde!
		muro_fisico.queue_free()     # Borramos el muro para que puedas pasar

# Esta función la llamaremos cuando el jugador interactúe o choque con el muro
func comprar_isla(jugador):
	if jugador.dinero >= precio_isla:
		jugador.dinero -= precio_isla
		comprada = true
		actualizar_isla()
		print("¡Isla comprada con éxito!")
	else:
		print("No tienes suficiente dinero. Cuesta: $", precio_isla)
