extends CharacterBody2D

var speed = 150;
var direcao;
@onready var hp = $vida
func _ready() -> void:
	randomize();
	var direc = [Vector2.UP + Vector2.LEFT,Vector2.DOWN + Vector2.LEFT, Vector2.UP + Vector2.RIGHT];
	direcao = direc[randi() % 3];

	$hurtbox.connect("dano", Callable(self, "_dano_hurtbox"))
	hp.connect("vida_zerada",Callable(self,"_morte"))
func _morte(val:bool):
	if(val == true):
		print("MORREU")
		queue_free();
func _dano_hurtbox(val:int):
	print(hp.vida_atual);
	hp.set_vida(-val);

func _process(delta:float) -> void:
	velocity = speed * direcao;
	move_and_slide();

func _physics_process(delta: float) -> void:
	
	if get_slide_collision_count() > 0:
		var colision = get_slide_collision(0);
		direcao = direcao.bounce(colision.get_normal());
