extends Node

# Global Audio Bus
var master_bus = AudioServer.get_bus_index("Master")

func set_volume(linear_value: float):
	var safe_linear = clamp(linear_value, 0.0, 1.0)
	var db_value = linear_to_db(safe_linear)
	AudioServer.set_bus_volume_db(master_bus, min(db_value, 0.0))
	
	# Mute
	AudioServer.set_bus_mute(master_bus, linear_value <= 0.01)
