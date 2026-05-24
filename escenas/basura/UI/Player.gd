# Player.gd
extends CharacterBody2D

# Stats
var max_health = 100
var health = 100
var xp = 0
var max_xp = 100
var level = 1

# UI References
@onready var hud = $HUD
@onready var pause_menu = $PauseMenu
@onready var game_over_screen = $GameOverScreen

func _ready():
	update_hud()
	pause_menu.hide()
	game_over_screen.hide()
	
	# Conectar botones
	$PauseMenu/ResumeButton.pressed.connect(_on_resume)
	$PauseMenu/QuitButton.pressed.connect(_on_quit)
	$GameOverScreen/RestartButton.pressed.connect(_on_restart)
	$GameOverScreen/QuitButton.pressed.connect(_on_quit)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
	
	if Input.is_action_just_pressed("inventory"):
		hud.get_node("InventoryGrid").visible = !hud.get_node("InventoryGrid").visible

func _physics_process(delta):
	if get_tree().paused: return
	
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * 300
	move_and_slide()

func take_damage(amount):
	health = max(0, health - amount)
	update_hud()
	
	if health <= 0:
		game_over()

func gain_xp(amount):
	xp += amount
	if xp >= max_xp:
		level_up()
	update_hud()

func level_up():
	level += 1
	xp -= max_xp
	max_xp = int(max_xp * 1.2)
	update_hud()

func update_hud():
	hud.get_node("HealthBar").max_value = max_health
	hud.get_node("HealthBar").value = health
	hud.get_node("XPBar").max_value = max_xp
	hud.get_node("XPBar").value = xp
	hud.get_node("LevelLabel").text = "Nivel " + str(level)

func toggle_pause():
	get_tree().paused = !get_tree().paused
	pause_menu.visible = get_tree().paused

func game_over():
	get_tree().paused = true
	game_over_screen.show()

func _on_resume():
	get_tree().paused = false
	pause_menu.hide()

func _on_restart():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit():
	get_tree().quit()
