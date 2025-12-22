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
@export var portrait:Texture2D

@export_category("Stats")
@export_range(0,15) var strength = 7
@export_range(0,15) var dexterity = 7
@export_range(0,15) var intelligence = 7
@export_range(0,15) var sanity = 100

@export_category("Traits")
@export var traits:Array[BaseTrait]

@export_category("Relationships")
@export var matches:Array[Enums.Pioneers]
