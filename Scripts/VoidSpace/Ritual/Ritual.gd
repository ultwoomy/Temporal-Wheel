extends Control
class_name Ritual


#@ Constants
const CANDLE_SPRITE_ENABLED : CompressedTexture2D = preload("res://Sprites/VoidSpace/candles/candle1enabled.png")
const CANDLE_SPRITE_DISABLED : CompressedTexture2D = preload("res://Sprites/VoidSpace/candles/candle1disabled.png")


#@ Onready Variables
@onready var candles : Array[RitualCandle] = [
	$Candle1,
	$Candle2,
	$Candle3,
	$Candle4,
	$Candle5,
	$Candle6,
]
