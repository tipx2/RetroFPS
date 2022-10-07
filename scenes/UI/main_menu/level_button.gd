extends TextureButton

var level = 0

func number_self(number):
	level = number
	$"%level_label".text = "Level " + str(number + 1)
