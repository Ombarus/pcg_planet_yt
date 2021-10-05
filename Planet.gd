tool
extends Spatial

export(Resource) var planet_data setget set_planet_data

func set_planet_data(val):
	planet_data = val
	on_data_changed()
	if planet_data != null and not planet_data.is_connected("changed", self, "on_data_changed"):
		planet_data.connect("changed", self, "on_data_changed")
	
func on_data_changed():
	planet_data.min_height = 99999.0
	planet_data.max_height = 0.0
	for child in get_children():
		var face := child as PlanetMeshFace
		face.regenerate_mesh(planet_data)

