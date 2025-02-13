class_name Projectile
extends Area2D

var velocity: float
var lifetime: float
export var damage: int

var team = Units.TeamID.Neutral

func _ready():
	connect("area_entered",self, "_on_area_entered")

func _process(delta):
	global_position += Vector2(velocity * delta, 0.0).rotated(rotation)
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()


func _on_area_entered(area):
	if not area.is_in_group("hit_area"):
		return
	if visible and team != area.get_parent().attributes.primary.unit_team:
		var enemy = area.get_parent()
		on_impact(enemy)
		enemy.attributes.stats.emit_signal("change_property", "health", enemy.attributes.stats.health - damage, funcref(enemy, "_on_attributes_stats_changed"))
		visible = false
		queue_free()


func on_impact(enemy):
	pass
