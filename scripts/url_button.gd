extends Button

@export var link: String

func pressed_button():
	OS.shell_open(link)
