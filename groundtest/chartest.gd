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
@export var gravidade = 900;

const dash_spd = 2100;


#tem q fazer o dash 

func dash_gound():
	print(last_action);
	if last_action == 1:
		velocity.x = dash_spd;
		velocity.y = dash_spd;
	if last_action == 2:
		velocity.x = -dash_spd;
		velocity.y = dash_spd;
	state = 2;
	move_and_slide();
func dash_diagonal():
	print(last_action);
	if last_action == 1:
		velocity.x = (dash_spd) / 4;
		velocity.y = (-dash_spd) / 4;
	if last_action == 2:
		velocity.x = (-dash_spd) / 4;
		velocity.y = (-dash_spd) / 4;
	state = 2;
	move_and_slide();
func dash():
	if not is_on_floor():
		if Input.is_action_pressed("cima"):
			dash_diagonal();
		else:
			dash_gound();
func abaixar():
	var sprite = $Sprite2D;
	var colission = $CollisionShape2D.shape;
	#colission.extents *= 0.5;
	sprite.scale = Vector2(0.7,0.4);



#quando instancia
func _ready() -> void:
	last_action = -1;
#por entrada
func get_input():
	if Input.is_action_pressed("direita"):
		velocity.x = runspeed;
		last_action = 1;
	if Input.is_action_pressed("esquerda"):
		velocity.x = -runspeed;
		last_action = 2;
	if Input.is_action_pressed("baixo"):
		abaixar();
		print("BAIXAR");
	if Input.is_action_pressed("dash"):
		dash();
		print("DASH");

	if !Input.is_anything_pressed():
		velocity.x = 0;
#por segundo
func _process(delta:float) -> void:
	get_input();
	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += delta * gravidade;
	else:
		if Input.is_action_pressed("cima"):
			velocity.y -= jumpspeed;
	move_and_slide();
