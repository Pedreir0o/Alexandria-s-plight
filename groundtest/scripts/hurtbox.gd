class_name hurtbox
extends Area2D

signal dano(val:int)

func _ready():
	collision_mask = 2;
	collision_layer = 1;
	connect("area_entered", _on_area_entered);

func _on_area_entered(hit: Area2D) ->void:
	if hit is hitbox:
		if hit.get_parent() == self.get_parent():
			return
		print("A")
		dano.emit(hit.damage);
