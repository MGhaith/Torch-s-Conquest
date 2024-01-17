extends MeshInstance2D

var canOpenDoor : bool = false

func _process(_delta):
	if canOpenDoor:
		DestroyDoor()

func OpenDoor():
	canOpenDoor = true
	printt("door Opened")

func DestroyDoor() -> void:
	queue_free()
