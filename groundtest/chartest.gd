extends CharacterBody2D

#@export var velocidade = Vector2.ZERO;
var last_action;
var dash_cd = 0;
var state = 0;
@export var runspeed = 300;
var jumpspeed = 400;
@export var gravidade = 900;

#tem q fazer o dash
func dash():
	print(last_action);
	if dash_cd != 0:
		return;
	if last_action == 1:
		velocity.x = 2100;
		print(velocity.x);
	if last_action == 2:
		velocity.x = -2100;
		print(velocity.x);
	move_and_slide();
func abaixar():
	var sprite = $Sprite2D;
	var colission = $CollisionShape2D.shape;
	colission.extents *= 0.5;
	sprite.scale = Vector2(0.7,0.4);
	state = 1;
func levantar():
	var sprite = $Sprite2D;
	var colission = $CollisionShape2D.shape;
	colission.extents *= 1.5;
	sprite.scale = Vector2(1.3,1.6);


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
	if state == 1:
		levantar();
	if !Input.is_anything_pressed():
		velocity.x = 0;
#por segundo
func _process(delta:float) -> void:
	get_input();
	dash_cd -= 1; #balancear o cooldown
	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += delta * gravidade;
	else:
		if Input.is_action_pressed("cima"):
			velocity.y -= jumpspeed;
	move_and_slide();
