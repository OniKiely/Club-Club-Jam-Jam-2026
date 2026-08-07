extends Node

var states = []
var current_state = null
var stopped = false

#adds all states at runtime to states
#sets current state to state 0 (default)
func _ready() -> void:
	for state in self.get_children():
		states.append(state)
	if states.size() > 0:
		current_state = states[0]
		current_state.enter()
	else:
		printerr("No states found in node " + str(get_parent().name))

#switches to the state through state_name using the node's name. 
#Case matters- "Default" != "default"
func switch_to(state_name : String) -> void:
	if !stopped:
		for state in states:
			if state.name == state_name:
				if current_state:
					current_state.exit()
				current_state = state
				current_state.enter()
				return
		#if state wasn't found
		printerr("State \"" + state_name + "\" not found in node " + str(get_parent().name) + " StateMachine")

#stops the StateMachine, usually used when the node is doing
#something right before calling queue_free()
func stop() -> void:
	stopped = true
	current_state.exit()
	current_state = null

#runs the current state's process
func _process(delta: float) -> void:
	if current_state && !stopped:
		current_state.run(delta)
