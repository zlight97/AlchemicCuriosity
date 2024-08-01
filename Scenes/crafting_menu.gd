extends CanvasLayer

signal item_crafted

var normal = preload("res://assets/buttons/normal_button.tres")
var pressed = preload("res://assets/buttons/pressed_button.tres")
var hover = preload("res://assets/buttons/hover_button.tres")
var disabled = preload("res://assets/buttons/disabled_button.tres")

func _populate_button_list(data):
	for item in data["recipe"]:
		var ingStr = ""
		var ings = item["ingredients"]
		var isDisabled = false
		for i in range(len(ings)):
			if i%2 == 0:
				ingStr = ingStr + str(ings[i])
			else:
				ingStr= ingStr + "x%s, " % ings[i].replace("_"," ").capitalize()
				if not ings[i] in data["stock"] or data["stock"][ings[i]] < ings[i-1]:
					isDisabled = true
			
		ingStr = ingStr.substr(0,len(ingStr)-2)
		var button_text = "%s\n%s" % [item["name"].capitalize(),ingStr]
		var button_label := RichTextLabel.new()
		button_label.set_text(button_text)
		button_label.set_size(Vector2(305,48))
		button_label.set_position(Vector2(20,9))
		button_label.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		button_label.add_theme_font_size_override("normal_font_size", 16)
		var button:= TextureButton.new()
		button.add_child(button_label)
		button.stretch_mode = TextureButton.STRETCH_SCALE
		button.texture_normal = normal
		button.texture_hover = hover
		button.texture_pressed = pressed
		button.texture_disabled = disabled
		button.disabled = isDisabled
		button.pressed.connect(button_pressed.bind(item))
		$CraftingMenu/ButtonContainer/ButtonList.add_child(button)

func button_pressed(item):
	var player = get_node("/root/SceneManager").player
	item_crafted.emit(item)
	player.item_crafted(item)
	get_node("/root/SceneManager").create_crafting(player.ingredients)
	queue_free()
