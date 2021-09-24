tool
extends Resource

class_name PlanetData

export var radius := 1.0 setget set_radius
export var resolution := 10 setget set_resolution

func set_radius(val):
	radius = val
	emit_signal("changed")

func set_resolution(val):
	resolution = val
	emit_signal("changed")
