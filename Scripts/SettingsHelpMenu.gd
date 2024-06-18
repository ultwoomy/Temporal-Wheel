extends Panel


#@ Export Variables
@export var text : Label


#@ Virtual Methods
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	text.text = "This help page is currently under construction"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#@ Public Methods
func wheelSpaceHelp():
	text.text = "WHEELSPACE\nPress the button labelled spin to gain momentum. Momentum is a currency used in several places, and it also boosts the spin rate of the
				wheel at a logarithmic rate. Press grow to toggle growing on. Growing consumes momentum every wheel rotation. When the bar under it becomes full, 
				your size will increase, which gives a linear multiplier to your momentum gain. If it's been several rotations and you don't see a bar or the bar is
				red, it's currently off and will not absorb any momentum. Condense consumes 1 size per click, and gives a rotation and momentum bonus.\n\n
				After getting the third sigil, upon clicking the wheel in the center, you will be taken to the ascension screen. The identity bonus is a 
				multiplier to your momentum that applies upon rebirthing. If you don't feel like you're making any progress in that value, try augmenting
				the fourth sigil in packsmith, and selecting anything except the option that says nothing.\n\nAlso that vague silhoutte will be clickable
				upon getting the candle sigil."


func mushSpaceHelp():
	text.text = "MUSHSPACE\nYou can plant up to 4 mushrooms at a time. Simply use the arrow keys (the ones on the screen, not the ones on your keyboard), to bring
				up the wanted mushroom, then press plant to plant it, which should be shown by a number above one of the plots. You can remove shrooms that aren't
				fully grown."
