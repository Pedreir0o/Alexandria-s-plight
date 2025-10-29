extends CharacterBody2D


var states = ["idle","atirar","standby"]
var estado_atual;
var speed = 100;
func mov():
	randomize();
	velocity.x = speed if (randi() % 2) == 0 else -speed; 
	
func idle():
	velocity.x = 0;
	velocity.y = 0;

func atirar():
	#passo 1: feixe
	$hitbox/Sprite2D.visible = true;
	#$hitbox/hit.
	
func standby():
	mov();
	
func _ready() -> void:
	estado_atual = 0;
	$hitbox.monitoring = false;


func _process(delta: float) -> void:
	match estado_atual:
		"0":
			idle();
		"1":
			atirar();
		"2":
			standby();
