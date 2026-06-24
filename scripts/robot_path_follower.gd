extends Node2D
class_name RobotPathFollower
@export var fixed_speed: float = 100
@export var normal_speed_multiplier : int
@export var rubber_band : bool
@export var rubber_band_treshold : float = 1000
@export var rubber_speed_multiplier : int
@export var path : Path2D
var all_points : Array[Vector2]

var current_point : int = -1:
	set(value):
		if current_point != value:
			current_point = value
			current_point_changed.emit(current_point)

var current_speed_multiplier : int:
	set(value):
		if current_speed_multiplier != value:
			current_speed_multiplier = value
			current_speed_changed.emit(current_point)

signal current_point_changed(value : int)
signal current_speed_changed(value : int)


func _ready() -> void:
	current_speed_multiplier = normal_speed_multiplier
	current_point_changed.connect(_on_current_point_changed)
	current_point = 0
	_get_all_points()

func _process(delta: float) -> void:
	_handle_points(delta)
	if rubber_band:
		_rubber_band_check()

func _get_all_points():
	var curve : Curve2D = path.curve
	for point_number in curve.point_count:
		var point_position = curve.get_point_position(point_number)
		all_points.append(point_position)
	#print(all_points)

func _rubber_band_check():
	var player : Player = get_parent().find_child("Player")
	var distance_to_player = self.global_position.distance_to(player.global_position)
	var direction_to_player = self.global_position.direction_to(player.global_position).sign()
	print(distance_to_player, direction_to_player)
	if direction_to_player.x == 1.0:
		if distance_to_player > rubber_band_treshold:
			current_speed_multiplier = rubber_speed_multiplier
		else:
			current_speed_multiplier = normal_speed_multiplier
	else:
		current_speed_multiplier = normal_speed_multiplier

func _handle_points(delta : float):
	if not global_position.distance_to(all_points[current_point]) < 10.0 :
		var direction = global_position.direction_to(all_points[current_point])
		global_position +=  direction * (fixed_speed*current_speed_multiplier) * delta
	else:
		if current_point+1 < all_points.size():
			current_point += 1

func _on_current_point_changed(value:int):
	print("now on : ", value)
