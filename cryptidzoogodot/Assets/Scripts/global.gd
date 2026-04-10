extends Node

#In general
var stamina = 0
var walkingSound
var character_position = Vector3(0,0,0)
var wendigoLevel = false

#Zoo Things
var afterWendy = false
var afterMM = false
var afterGnome = false
var afterNess = false
var firstLevel = true

#Universal Character Controller
var wendyPower = false
var mothmanPower = false
var gnomePower = false
var nessiePower = false

#Mothman Things
var animNum = 1.0
var plushCounter = 0
var mothman_Zoo_Compatability = 0


#Wendigo Things
var trapCounter = 1
var frozen = false


#Gnome Things
var thingsGathered = 0
var gnomeState = 0
var shroomsAte = 0
var playerShouldBeMoving = true
var HedgeCompleted = false
var convoDone = false
var wendyFound = true
var checkpoint = false
