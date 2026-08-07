extends Node

var states = []
var current_state = null

#adds all states at runtime to states
#sets current state to state 0 (default)
func _ready() -> void:
	for state in self.get_children():
		states.append(state)
	current_state = states[0]
	current_state.enter()

#switches to the state through state_name using the node's name. 
#Case matters- "Default" != "default"
func switch_to(state_name : String) -> void:
	for state in states:
		if state.name == state_name:
			current_state.exit()
			current_state = state
			current_state.enter()
			return
	
	#if state wasn't found
	printerr("State \"" + state_name + "\" not found in node " + str(get_parent().name) + " StateMachine")

#runs the current state's process
func _process(delta: float) -> void:
	current_state.run(delta)
