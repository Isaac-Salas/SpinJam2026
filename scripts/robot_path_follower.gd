extends Node2D
@export var fixed_speed: float = 100
@export var speed_multiplier : int
@export var target_robot : Robot
@export var path : Path2D
var all_points : Array[Vector2]
var current_point : int = -1:
	set(value):
		if current_point != value:
			current_point = value
			current_point_changed.emit(current_point)

signal current_point_changed(value : int)

func _ready() -> void:
	current_point_changed.connect(_on_current_point_changed)
	current_point = 0
	var curve : Curve2D = path.curve
	for point_number in curve.point_count:
		var point_position = curve.get_point_position(point_number)
		all_points.append(point_position)
	print(all_points)
	

func _process(delta: float) -> void:
	_handle_points(delta)

func _handle_points(delta : float):
	if not global_position.distance_to(all_points[current_point]) < 10.0 :
		var direction = global_position.direction_to(all_points[current_point])
		global_position +=  direction * (fixed_speed*speed_multiplier) * delta
	else:
		if current_point+1 < all_points.size():
			#print("done with point : ", current_point)
			current_point += 1
		else:
			print("done")

func _on_current_point_changed(value:int):
	print("now on : ", value)
