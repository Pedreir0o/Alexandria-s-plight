extends CharacterBody2D


var states = ["idle","atirar","standby"]
var estado_atual:int;
var speed:int = 100;
var jogador;
var atiravel:int = 1;
var ataque_state:int = 0;
@onready var hp = $vida;
@onready var rc = $RayCast2D
@onready var cd = $ATK_CD;
@onready var cd_state_atk = $ATK_STATE_CD;
func mov():
	randomize();
	velocity.x = speed if (randi() % 2) == 0 else -speed; 

func avistar():
	return true;
func idle():
	velocity.x = 0;
	velocity.y = 0;
	
	if avistar() == true:
		estado_atual = 2;
func atirar():
	var pos_player = to_local(jogador.position)
	rc.target_position = pos_player;
	if rc.get_collider() != jogador or atiravel == 0:
		return;
	
	if ataque_state == 0:
		#passo 1: feixe
		$hitbox/hit.shape.b = pos_player;
		pos_player = to_local(jogador.position)
		$hitbox/Sprite2D.visible = true;
		#$hitbox/Sprite2D.texture = load("res://assets/feixe.svg")
		cd_state_atk.start();
	
	
	if ataque_state == 1:
		#passo 2: tiro
		$hitbox/hit.shape.b = pos_player;
		#$hitbox/Sprite2D.texture = load("res://assets/tiro.svg")
		$hitbox.monitorable = true;
		print("TIRO")
		cd_state_atk.start()
	
	if ataque_state == 2:		
		#passo 3: cd;
		atiravel = 0;
		cd.start()
		$hitbox/hit.shape.b = Vector2(0, 0);
		$hitbox.monitorable = false;
		$hitbox/Sprite2D.visible = false;
		print("CD")
		ataque_state = 0;
func standby():
	mov();
	
func _ready() -> void:
	estado_atual = 1;
	jogador = get_parent().find_child("player")
	$hitbox.monitorable = false;
	$hurtbox.connect("dano", Callable(self, "_dano_hurtbox"))
	$vida.connect("vida_zerada",Callable(self,"_morte"))
func _morte(val:bool):
	if(val == true):
		#$AnimationPlayer.play("morte")
		#await $AnimationPlayer.animation_finished
		queue_free();
func _dano_hurtbox(val:int):
	hp.set_vida(-val);

func _process(delta: float) -> void:
	match estado_atual:
		0:
			idle();
		1:
			atirar();
		2:
			standby();


func _on_timer_timeout() -> void:
	atiravel = 1;


func _on_atk_state_cd_timeout() -> void:
	print("AAA")
	ataque_state = ataque_state + 1;
