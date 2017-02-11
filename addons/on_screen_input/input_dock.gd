tool
extends VBoxContainer

var text = "" setget set_input_text,get_input_text
var bt_left = false setget set_bt_left,get_bt_left
var bt_right = false setget set_bt_right,get_bt_right
var bt_mid = false setget set_bt_mid,get_bt_mid
var weel_up = false setget set_weel_up,get_weel_up
var weel_down = false setget set_weel_down,get_weel_down


onready var label = get_node("text")
onready var node_bt_left = get_node("bg/bt_left")
onready var node_bt_right = get_node("bg/bt_right")
onready var node_bt_mid = get_node("bg/bt_mid")
onready var node_weel_up = get_node("bg/weel_up")
onready var node_weel_down = get_node("bg/weel_down")

func _ready():
	pass

func set_bt_left(val):
	if val:
		node_bt_left.show()
	else:
		node_bt_left.hide()

func set_bt_right(val):
	if val:
		node_bt_right.show()
	else:
		node_bt_right.hide()

func set_bt_mid(val):
	if val:
		node_bt_mid.show()
	else:
		node_bt_mid.hide()

func set_weel_up(val):
	if val:
		node_weel_up.show()
	else:
		node_weel_up.hide()

func set_weel_down(val):
	if val:
		node_weel_down.show()
	else:
		node_weel_down.hide()

func get_bt_left():
	return node_bt_left.is_visible()

func get_bt_right():
	return node_bt_right.is_visible()

func get_bt_mid():
	return node_bt_mid.is_visible()

func get_weel_up():
	return node_weel_up.is_visible()

func get_weel_down():
	return node_weel_down.is_visible()

func set_input_text(val):
	label.set_text(val)

func get_input_text():
	return label.get_text()