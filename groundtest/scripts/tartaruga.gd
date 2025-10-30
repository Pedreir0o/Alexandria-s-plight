extends CharacterBody2D


var states = ["idle","atirar","standby"]
var estado_atual;
var speed = 100;
@onready var hp = $vida;

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
	$hurtbox.connect("dano", Callable(self, "_dano_hurtbox"))
	$vida.connect("vida_zerada",Callable(self,"_morte"))
func _morte(val:bool):
	if(val == true):
		#$AnimationPlayer.play("morte")
		#await $AnimationPlayer.animation_finished
		print("MORREU")
		queue_free();
func _dano_hurtbox(val:int):
	print(hp.vida_atual);
	hp.set_vida(-val);

func _process(delta: float) -> void:
	match estado_atual:
		"0":
			idle();
		"1":
			atirar();
		"2":
			standby();
