# Main.gd - Asígnale esto a un Node2D vacío
extends Node2D

func _ready():
	create_player()

func create_player():
	# Crear el jugador como CharacterBody2D
	var player = CharacterBody2D.new()
	player.name = "Player"
	player.position = Vector2(512, 300)
	
	# Agregar sprite
	var sprite = Sprite2D.new()
	sprite.texture = create_placeholder_texture()
	player.add_child(sprite)
	
	# Agregar colisión
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 20
	collision.shape = shape
	player.add_child(collision)
	
	# Crear HUD
	var hud = create_hud()
	player.add_child(hud)
	
	# Crear PauseMenu
	var pause_menu = create_pause_menu()
	player.add_child(pause_menu)
	
	# Crear GameOverScreen
	var game_over = create_game_over()
	player.add_child(game_over)
	
	# Asignar script
	player.set_script(preload("res://Player.gd"))
	
	add_child(player)

func create_placeholder_texture():
	var image = Image.create(32, 32, false, Image.FORMAT_RGBA8)
	image.fill(Color.BLUE)
	return ImageTexture.create_from_image(image)

func create_hud():
	var hud = CanvasLayer.new()
	hud.name = "HUD"
	
	# Barra de vida
	var health_bar = ProgressBar.new()
	health_bar.name = "HealthBar"
	health_bar.position = Vector2(20, 20)
	health_bar.size = Vector2(300, 30)
	hud.add_child(health_bar)
	
	# Barra de XP
	var xp_bar = ProgressBar.new()
	xp_bar.name = "XPBar"
	xp_bar.position = Vector2(20, 60)
	xp_bar.size = Vector2(300, 30)
	hud.add_child(xp_bar)
	
	# Label de nivel
	var level_label = Label.new()
	level_label.name = "LevelLabel"
	level_label.position = Vector2(20, 100)
	level_label.text = "Nivel 1"
	hud.add_child(level_label)
	
	# Grid de inventario
	var inventory = GridContainer.new()
	inventory.name = "InventoryGrid"
	inventory.position = Vector2(800, 20)
	inventory.size = Vector2(250, 200)
	inventory.columns = 3
	inventory.visible = false
	hud.add_child(inventory)
	
	return hud

func create_pause_menu():
	var menu = Panel.new()
	menu.name = "PauseMenu"
	menu.position = Vector2(412, 200)
	menu.size = Vector2(200, 150)
	menu.visible = false
	menu.modulate = Color(0, 0, 0, 0.8)
	
	var resume = Button.new()
	resume.name = "ResumeButton"
	resume.text = "Reanudar"
	resume.position = Vector2(50, 30)
	resume.size = Vector2(100, 40)
	menu.add_child(resume)
	
	var quit = Button.new()
	quit.name = "QuitButton"
	quit.text = "Salir"
	quit.position = Vector2(50, 80)
	quit.size = Vector2(100, 40)
	menu.add_child(quit)
	
	return menu

func create_game_over():
	var game_over = Panel.new()
	game_over.name = "GameOverScreen"
	game_over.position = Vector2(362, 200)
	game_over.size = Vector2(300, 200)
	game_over.visible = false
	game_over.modulate = Color(0, 0, 0, 0.9)
	
	var title = Label.new()
	title.text = "GAME OVER"
	title.position = Vector2(90, 30)
	title.add_theme_font_size_override("font_size", 30)
	game_over.add_child(title)
	
	var restart = Button.new()
	restart.name = "RestartButton"
	restart.text = "Reiniciar"
	restart.position = Vector2(100, 80)
	restart.size = Vector2(100, 40)
	game_over.add_child(restart)
	
	var quit = Button.new()
	quit.name = "QuitButton"
	quit.text = "Salir"
	quit.position = Vector2(100, 130)
	quit.size = Vector2(100, 40)
	game_over.add_child(quit)
	
	return game_over
