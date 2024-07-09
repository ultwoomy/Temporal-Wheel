extends Resource
class_name NightChallengeData

@export var requestList : Array[Request]
@export var hungerLimit : float
@export var hungerCurrent : float
@export var hungerDeduction : float
@export var completedRequests : int
@export var extraHungry : bool
@export var numberOfLosses : int

func _init():
	resetData()

func resetData() -> void:
	hungerLimit = 100
	hungerCurrent = 0
	hungerDeduction = 0
	completedRequests = 0
	extraHungry = false
	numberOfLosses = 0
	initRequests()
	
func initRequests():
	var temp = Request.new()
	temp.initializePrimary("momentum",100)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("rotations",10)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("momentum",1000)
	temp.initializeSecondary("rotations",20)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("momentum",2000)
	temp.initializeSecondary("rotations",40)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("momentum",4000)
	temp.initializeSecondary("rotations",60)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("momentum",10000)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("momentum",10000)
	temp.initializeSecondary("rotations",80)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("momentum",10000)
	temp.initializeSecondary("rotations",100)
	requestList.append(temp)
	temp = Request.new()
	temp.initializePrimary("cheese",0)
	requestList.append(temp)
