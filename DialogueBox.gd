extends CanvasLayer
#This script is used to define all of the logic of a DialogueBox, children logic should probably be stored here
var dialogue = ["TEXT ERROR"]
var page = 0
var scrollSpeed = .2
var speaker_name = null
var m_sprite = null
var spriteLoc = null
var sprite = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$ContentText.text = dialogue[page]
	$ContentText.visible_ratio = 0
	setSpeakerName(speaker_name)
	$"ScrollTimer".start()
	setupSprite()
	set_process_input(true)

func setSpeakerName(sname):
	if sname:
		$"NameLabel".text = sname
		$"Nameplate".show()
		$"NameLabel".show()

func setupSprite():
	if m_sprite:
		if typeof(m_sprite) == TYPE_STRING:
			m_sprite = load(m_sprite)
			if not spriteLoc or 'r' in spriteLoc.to_lower():
				sprite = $SpriteR
			elif 'l' in spriteLoc.to_lower():
				sprite = $SpriteL
			sprite.sprite_frames = m_sprite
			sprite.show()
			sprite.animation = "talking"
			sprite.play()

func newDialogue(dialogue_list: Array, person_name, sprite, sprite_pos):
	speaker_name = person_name
	dialogue = dialogue_list
	m_sprite = sprite
	spriteLoc = sprite_pos
	page=0

func nextPage():
	if page+1 < len(dialogue):
		page+=1
		$ContentText.text=dialogue[page]
		$ContentText.visible_ratio=0
		sprite.animation = "talking"
		sprite.play()
	else:
		endDialogue()

func endDialogue():
	$"ScrollTimer".stop()
	hide()

func _input(event):
	if event.is_pressed() and (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_key_pressed(KEY_SPACE)):
		if $ContentText.visible_ratio < 1:
			$ContentText.visible_ratio = 1
			sprite.animation = "normal"
			sprite.play()
		else:
			nextPage()

func _on_scroll_timer_timeout():
	if $ContentText.visible_ratio < 1:
		$ContentText.visible_ratio+=scrollSpeed
	elif $ContentText.visible_ratio >=1:
		$ContentText.visible_ratio = 1
		sprite.animation = "normal"
		sprite.play()
		
