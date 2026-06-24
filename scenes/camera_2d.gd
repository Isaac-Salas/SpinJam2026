extends Camera2D
@export var target_follow : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if target_follow:
		#self.global_position = target_follow.global_position
		self.global_position = lerp(self.global_position,target_follow.global_position,delta*5)
