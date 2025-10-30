class_name vida
extends Node

@export var max_vida:int = 3;
@export var vencivel = 0;
var vida_atual:int = max_vida;


signal mudança_vida(val: int);
signal vida_zerada(val:bool);

func set_max_vida(val:int):
	max_vida = val;
	
	if vida_atual > max_vida:
		vida_atual = max_vida;
	emit_signal("mudança_vida",val);
func get_max_vida():
	return max_vida;
func get_vida():
	return vida_atual;
func set_vida(val:int):
	if vencivel == 1:
		return;
	vida_atual = vida_atual + val;
	if vida_atual <= 0:
		vida_atual = 0;
		emit_signal("vida_zerada",true);
	emit_signal("mudança_vida",val);
func set_imortalidade(val:int):
	vencivel = val;
