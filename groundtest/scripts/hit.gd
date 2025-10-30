class_name hitbox

extends Area2D
@export var damage = 1;
var active = 0;
func _init() -> void:
	collision_layer = 2;
	collision_mask = 1;

func set_damage(val:int):
	damage = val;
func get_damage():
	return damage;
