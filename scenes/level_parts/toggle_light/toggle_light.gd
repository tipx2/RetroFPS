extends Spatial

func turn_on():
	$SpotLight.light_energy = 1
	$on_player.play()

func turn_off():
	$SpotLight.light_energy = 0
	$off_player.play()
