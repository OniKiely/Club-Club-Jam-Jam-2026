extends Resource

class_name ShellData


@export var playerShellTexture:Texture
@export var pickupTexture:Texture


# ~~ shell stats ~~

#attack
@export var canShoot:bool = false
@export var attack_cooldown:float = 0
@export var attack_damage:int = 10
@export var bullet_scene:PackedScene

#movement
@export var can_jump:bool = true
@export var jump_strength:float = -400
@export var max_speed:int = 250
@export var acceleration:int = 700
