class_name BasePioneer
extends Resource

@export_category("Basic Info")
@export var name:String = "Pearl"
@export var gender:Enums.PioneerGender = Enums.PioneerGender.Female

@export_category("Stats")
@export_range(1,15) var strength = 6
@export_range(1,15) var dexterity = 8
@export_range(1,15) var intelligence = 7
@export var traits:Array[BaseTrait]
