tool

extends EditorPlugin

var last_ev = []
var repeated = []
var dock
var up_timer
var down_timer

func _enter_tree():
	call_deferred("raise")
	if dock == null:
		dock = preload("res://addons/on_screen_input/input_dock.tscn").instance()
		up_timer = Timer.new()
		up_timer.set_wait_time(0.1)
		up_timer.set_one_shot(true)
		down_timer = up_timer.duplicate()
		dock.add_child(up_timer)
		dock.add_child(down_timer)
	add_control_to_dock(DOCK_SLOT_LEFT_BR,dock)
	dock.set_area_as_parent_rect(0)
	set_process_input(true)

func _exit_tree():
	remove_control_from_docks(dock)
	set_process_input(false)

func _input(ev):
	if ev.type == InputEvent.KEY and ev.pressed and !ev.is_echo():
		if ev.scancode == KEY_CONTROL or ev.scancode == KEY_ALT or ev.scancode == KEY_SHIFT:
			return
		if last_ev.size() > 0 and ev == last_ev[last_ev.size()-1]:
			repeated[repeated.size()-1] +=1
		else:
			last_ev.push_back(ev)
			repeated.push_back(1)
		if last_ev.size() > 5:
			last_ev.pop_front()
			repeated.pop_front()
		var text = ""
		for i in range(0,last_ev.size()):
			if i > 0:
				text += "\n"
			if last_ev[i].control:
				text += "CONTROL + "
			if last_ev[i].alt:
				text += "ALT + "
			if last_ev[i].shift:
				text += "SHIFT + "
			text += OS.get_scancode_string(last_ev[i].scancode)
			if repeated[i] > 1:
				text += " x " + str(repeated[i])
		dock.text = text
	if ev.type == InputEvent.MOUSE_BUTTON and !ev.is_echo():
		if ev.button_index == BUTTON_LEFT:
			dock.bt_left = ev.pressed
		if ev.button_index == BUTTON_RIGHT:
			dock.bt_right = ev.pressed
		if ev.button_index == BUTTON_MIDDLE:
			dock.bt_mid = ev.pressed
		if ev.button_index == BUTTON_WHEEL_UP:
			dock.weel_up = true
			up_timer.start()
			yield(up_timer,"timeout")
			dock.weel_up = false
		if ev.button_index == BUTTON_WHEEL_DOWN:
			dock.weel_down = true
			down_timer.start()
			yield(down_timer,"timeout")
			dock.weel_down = false
