extends CharacterBody2D
#FALTA: 
#  1- abaixar e levantar
#  2- cd pro dash
#  3- retoques para ter um "feeling" melhor
#@export var velocidade = Vector2.ZERO;
var last_action;
var dash_cd = 0;
var state = 0;
@export var runspeed = 300;
var jumpspeed = 400;
var gravidade = 900;

const dash_spd = 2100;


#tem q fazer o dash 

func dash_gound():
	print(last_action);
	if last_action == 1:
		velocity.x = dash_spd;
		velocity.y = dash_spd;
	if last_action == -1:
		velocity.x = -dash_spd;
		velocity.y = dash_spd;
	state = 2;
	move_and_slide();
func dash_diagonal():
	print(last_action);
	if last_action == 1:
		velocity.x = (dash_spd) / 4;
		velocity.y = (-dash_spd) / 4;
	if last_action == -1:
		velocity.x = (-dash_spd) / 4;
		velocity.y = (-dash_spd) / 4;
	state = 2;
	move_and_slide();
func dash():
	if not is_on_floor():
		if Input.is_action_pressed("cima"):
			dash_diagonal();
			if $RayCast2DE.is_colliding() or $RayCast2DD.is_colliding():
				last_action *= -1;
				dash_diagonal();
		else:
			dash_gound();
func abaixar():
	var sprite = $Sprite2D;
	var colission = $CollisionShape2D;
	colission.scale.y = 0.5;
	sprite.scale = Vector2(0.6,0.4);
func levantar():
	var sprite = $Sprite2D;
	var colission = $CollisionShape2D;
	colission.scale.y = 1;
	sprite.scale = Vector2(0.8,0.5);
func ataque():
	if last_action == -1:
		$hitbox.position.x = -237;
	else:
		$hitbox.position.x = 237;
	$hitbox/Sprite2D.visible = true;
func end_ataque():
	$hitbox.monitoring = false;
	$hitbox/Sprite2D.visible = false;
#quando instancia
func _ready() -> void:
	last_action = 0;
	end_ataque();
#por entrada
func get_input_atack():
	if Input.is_action_just_pressed("bater"):
		ataque();
	if Input.is_action_just_released("bater"):
		end_ataque();

func get_input_mov():
	if Input.is_action_pressed("direita"):
		velocity.x = runspeed;
		last_action = 1;
	if Input.is_action_pressed("esquerda"):
		velocity.x = -runspeed;
		last_action = -1;
	if Input.is_action_pressed("baixo"):
		abaixar();
	if Input.is_action_pressed("dash"):
		dash();
	if Input.is_action_just_released("baixo"):
		levantar();
	if !Input.is_action_pressed("direita") and !Input.is_action_pressed("esquerda") && !Input.is_action_pressed("dash"):
		velocity.x = 0;
#por segundo
func _process(delta:float) -> void:
	get_input_mov();
	get_input_atack();
	
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		state = 0;
	if not is_on_floor():
		velocity.y += delta * gravidade;
	else:
		if Input.is_action_pressed("cima"):
			state = 1;
			velocity.y -= jumpspeed;
	move_and_slide();
