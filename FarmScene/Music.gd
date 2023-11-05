extends AudioStreamPlayer2D

var playing_battle_theme = false

# Called when the node enters the scene tree for the first time.
func _ready():
	play_maintheme()

func play_maintheme():
	stop()
	stream = preload("res://Assets/Music/main.mp3")
	play()
	playing_battle_theme = false

func play_combat():
	stop()
	stream = preload("res://Assets/Music/combat.mp3")
	play()
	playing_battle_theme = true


func _on_timer_timeout():
	if (playing_battle_theme):
		play_maintheme()
	else:
		play_combat()
