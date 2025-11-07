extends CharacterBody2D

var states = ["idle","parry", "ataque","walk"]
var estado_atual = 0;
var direc = 0;
var jogador;
var counter = 0;
var pjogador;
@onready var esquerda = $raycast_esquerda
@onready var hp = $vida;
@onready var direita = $raycast_direito
func idle():
	velocity.x = 0;
	velocity.y = 0;
	
	if esquerda.get_collider() == jogador:
		direc = -1;
		estado_atual = 3;
	if direita.get_collider() == jogador:
		direc = 1;
		estado_atual = 3;
func parry():
	if estado_atual != 1:
		pass;
	hp.set_imortalidade(1);
	counter = 1;
	
func ataque():
	$hitbox.monitorable = true;
	$hitbox.monitoring = true;
	$hitbox/Sprite2D.visible = true;
	if direc == -1:
		$hitbox.position.x = -157.5
	else:
		$hitbox.position.x = 157.5
	$hitbox.active = 1;
	counter = 0;
	return;
func walk():
	var target:Vector2 = global_position + Vector2(500,0);
	var dash_Speed = 500;
	if global_position.distance_to(target) > 1.0:
		var direction = (target - global_position).normalized()
		velocity = direction * dash_Speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
func _ready() -> void:
	estado_atual = 1;
	jogador = get_parent().find_child("player")
	$hitbox.monitorable = false;
	$hurtbox.connect("dano", Callable(self, "_dano_hurtbox"))
	$vida.connect("vida_zerada",Callable(self,"_morte"))
	$hurtbox.connect("dano", Callable(self, "parry"))
	
	
func _morte(val:bool):
	if(val == true):
		#$AnimationPlayer.play("morte")
		#await $AnimationPlayer.animation_finished
		queue_free();
func _dano_hurtbox(val:int):
	if counter == 1:
		jogador.hp.set_vida(-1);
		return;
	hp.set_vida(-val);

func _process(delta: float) -> void:
	match estado_atual:
		0:
			idle();
		1:
			parry();
		2:
			ataque();
func _physics_process(delta: float) -> void:
	if states == 3:
		walk();
