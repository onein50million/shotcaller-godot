extends Skill

var queued_casts = 0
export onready var damage: int = get_damage()
	
func cast() -> bool:
	var super_result = .cast()
	if super_result:
		var target = agent.targeted_enemy
		if not is_instance_valid(target):
			return super_result
		var target_attributes = target.get_node("Attributes")
		var agent_attributes = agent.get_node("Attributes")
		if target_attributes.primary.unit_team != agent_attributes.primary.unit_team:
			target_attributes.stats.emit_signal("change_property", "health", target_attributes.stats.health - damage, funcref(target, "_on_attributes_stats_changed"))
	return super_result
	
func get_damage():
	var skill = get_parent()
	var unit = skill.get_parent()
	var attributes = unit.get_node("Attributes")
	return attributes.stats.damage

func get_range():
	var skill = get_parent()
	var unit = skill.get_parent()
	var attributes = unit.get_node("Attributes")
	return attributes.radius.attack_range 
