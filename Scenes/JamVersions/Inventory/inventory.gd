extends Node

signal Changed
signal PoopsChanged

var items = {}
var poops = {}

# add negative to remove
func add_poop(type: Poop.PoopType, amount: int = 1):
	if (!poops.has(type)):
		poops[type] = 0	
	
	poops[type] += amount
	
	Changed.emit()
	PoopsChanged.emit()

func get_poops(type: Poop.PoopType) -> int:
	if (!poops.has(type)):
		return 0
	
	return poops[type]
