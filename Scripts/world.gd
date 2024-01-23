extends Node2D

const LightTexture = preload("res://Assets/Light.png")
const GRID_SIZE = 16

@onready var fog = $Fog

var display_width = ProjectSettings.get("display/window/size/viewport_width")
var display_hight = ProjectSettings.get("display/window/size/viewport_height")

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LightTexture.get_width()/2, LightTexture.get_height()/2)

# Called when the node enters the scene tree for the first time.
func _ready():
	var fog_image_width = display_width / GRID_SIZE
	var fog_image_height = display_hight / GRID_SIZE
	fogImage = fogImage.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	lightImage.convert(Image.FORMAT_RGBAH)
	fog.scale *= GRID_SIZE

func Update_fog(new_grid_position):
	var light_rect = Rect2(Vector2.ZERO, Vector2(lightImage.get_width(), lightImage.get_height()))
	fogImage.blend_rect(lightImage, light_rect, new_grid_position - light_offset)

	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture.create_from_image(fogImage)
	fog.texture = fogTexture
	
func  _input(_event):
	Update_fog(get_local_mouse_position() / GRID_SIZE)
