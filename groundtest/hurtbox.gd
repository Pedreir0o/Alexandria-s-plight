class_name hurtbox
extends Area2D

signal dano(val:int)

func _ready():
	connect("area_entered", _on_area_entered);

func _on_area_entered(hit: hitbox) ->void:
	if hitbox != null:
		dano.emit(hit.damage);
