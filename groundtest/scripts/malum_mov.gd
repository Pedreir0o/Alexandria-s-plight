extends CharacterBody2D


var speed = 150;
var direcao;

func _ready() -> void:
	randomize();
	var direc = [Vector2.DOWN + Vector2.LEFT,Vector2.UP + Vector2.LEFT, Vector2.DOWN + Vector2.RIGHT];
	direcao = direc[randi() % 3];
	

func _process(delta:float) -> void:
	velocity = speed * direcao;
	move_and_slide();

func _physics_process(delta: float) -> void:
	
	if get_slide_collision_count() > 0:
		var colision = get_slide_collision(0);
		direcao = direcao.bounce(colision.get_normal());
		
