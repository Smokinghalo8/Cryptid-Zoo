extends CSGBox3D

@export var amplitude: float = 0.3  # How high/low it moves
@export var frequency: float = 2  # How fast it moves
@export var phase_offset: float = 0.0 # Useful if you have multiple boxes and want them out of sync

var initial_y: float

func _ready():
	# Store the starting height so we move relative to it
	initial_y = position.y

func _process(delta):
	# Get the current time in seconds
	var time = Time.get_ticks_msec() / 1000.0
	
	# Calculate the new Y position using a sine wave
	# $y = A \cdot \sin(B \cdot t + C)$
	position.y = initial_y + sin(time * frequency + phase_offset) * amplitude
