extends "res://Character/Character.gd"

var lane: Lane
var current_lane_point = 1


func _ready():
	$Node/Line2D.visible = ProjectSettings.get("global/debug")
	._ready()
