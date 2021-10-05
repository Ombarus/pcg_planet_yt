tool
extends Resource

class_name PlanetData

export var radius := 1.0 setget set_radius
export var resolution := 10 setget set_resolution
export(Array, Resource) var planet_noise setget set_planet_noise
export var planet_color : GradientTexture setget set_planet_color

var min_height := 99999.0
var max_height := 0.0

func set_planet_color(val):
	planet_color = val
	if planet_color != null and not planet_color.is_connected("changed", self, "on_data_changed"):
		planet_color.connect("changed", self, "on_data_changed")


func set_radius(val):
	radius = val
	emit_signal("changed")

func set_resolution(val):
	resolution = val
	emit_signal("changed")

func set_planet_noise(val):
	planet_noise = val
	emit_signal("changed")
	for n in planet_noise:
		if n != null and not n.is_connected("changed", self, "on_data_changed"):
			n.connect("changed", self, "on_data_changed")

func on_data_changed():
	emit_signal("changed")
	
	
func point_on_planet(point_on_sphere : Vector3) -> Vector3:
	var elevation : float = 0.0
	var base_elevation := 0.0
	if planet_noise.size() > 0:
		base_elevation = (planet_noise[0].noise_map.get_noise_3dv(point_on_sphere*100.0))
		base_elevation = (base_elevation + 1.0) / 2.0 * planet_noise[0].amplitude
		base_elevation = max(0.0, base_elevation - planet_noise[0].min_height)
	for n in planet_noise:
		var mask := 1.0
		if n.use_first_layer_as_mask:
			mask = base_elevation
		var level_elevation = n.noise_map.get_noise_3dv(point_on_sphere*100.0)
		level_elevation = (level_elevation + 1.0) / 2.0 * n.amplitude
		level_elevation = max(0.0, level_elevation - n.min_height) * mask
		elevation += level_elevation
	return point_on_sphere * radius * (elevation+1.0)
