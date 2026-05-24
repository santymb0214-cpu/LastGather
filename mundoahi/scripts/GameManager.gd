extends Node
# Este script es un Node básico, solo guarda datos globales
# No necesita moverse ni detectar colisiones

var monedas: int = 10000
# Variable entera que guarda el dinero del jugador
# Empieza en 0 al inicio del juego

signal monedas_cambiadas(nuevo_valor)
# Señal que se emite cada vez que las monedas cambian
# La UI la escucha para actualizar el número en pantalla

func agregar_monedas(cantidad: int):
	# Recibe un número y lo suma al total de monedas
	monedas += cantidad
	# Avisa a todos los que escuchan que las monedas cambiaron
	emit_signal("monedas_cambiadas", monedas)

func gastar_monedas(cantidad: int) -> bool:
	# Primero verifica si hay suficiente dinero
	if monedas >= cantidad:
		# Si hay suficiente, resta las monedas
		monedas -= cantidad
		# Avisa que las monedas cambiaron
		emit_signal("monedas_cambiadas", monedas)
		# Devuelve true = la compra fue exitosa
		return true
	# Si no había suficiente dinero, devuelve false = compra fallida
	return false
