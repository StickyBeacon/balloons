extends Resource
class_name BalloonResource

@export var action_event : InputEvent
@export var player_color : Color
@export_range(0,11) var player_face : int
@export var items : Array[Resource]
@export var points : int = 0
@export var wins : int = 0
