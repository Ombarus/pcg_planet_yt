tool
extends Resource
class_name PlanetBiome

export var gradient : GradientTexture setget set_gradient
export var start_height : float setget set_start_height

func set_gradient(val):
	gradient = val
	emit_signal("changed")
	if not gradient.is_connected("changed", self, "bubble_signal_changed"):
		gradient.connect("changed", self, "bubble_signal_changed")

func set_start_height(val):
	start_height = val
	emit_signal("changed")

func bubble_signal_changed():
	emit_signal("changed")
