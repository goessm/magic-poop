extends AudioStreamPlayer2D

var playing_battle_theme = false

var maintheme_pos: float # playback position of main theme track

# Called when the node enters the scene tree for the first time.
func _ready():
	play_maintheme()

func play_maintheme():
	if (playing && !playing_battle_theme):
		return
		
	stop()
	stream = preload("res://Assets/Music/main.mp3")
	play(maintheme_pos)
	playing_battle_theme = false

func play_combat():
	if (playing && playing_battle_theme):
		return
	
	maintheme_pos = get_playback_position()
	stop()
	stream = preload("res://Assets/Music/combat.mp3")
	play()
	playing_battle_theme = true

