class_name BasePioneer
extends Resource

@export_category("Basic Info")
@export var id:Enums.Pioneers = Enums.Pioneers.Pearl
@export var name:String = "Pearl"
@export var firstname:String = "Pearl"
@export var surname:String = "Perfection"
@export var title:String = "The Ultimate"
@export var gender:Enums.PioneerGender = Enums.PioneerGender.Female
@export var icon:Texture2D
@export var card_arts:Array[Texture2D]
@export var portrait:Texture2D

var occupied:bool = false

@export_category("Stats")
@export_range(0,15, 1, "or_greater") var strength = 16
@export_range(0,15, 1, "or_greater") var dexterity = 16
@export_range(0,15, 1, "or_greater") var intelligence = 16
@export_range(0,100, 1, "or_less") var sanity = 50

@export_category("Traits")
@export var traits:Array[BaseTrait]

@export_category("Relationships")
@export var matches:Array[Enums.Pioneers]
