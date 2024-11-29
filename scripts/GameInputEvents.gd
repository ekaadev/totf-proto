class_name GameInputEvents

# Direction for player movement
static var direction: Vector2

# Function to get player movement input
# Player cant move diagonally
# Return: Vector2
static func movement_input() -> Vector2:
    if Input.is_action_pressed("left"):
        direction = Vector2.LEFT
    elif Input.is_action_pressed("right"):
        direction = Vector2.RIGHT
    elif Input.is_action_pressed("up"):
        direction = Vector2.UP
    elif Input.is_action_pressed("down"):
        direction = Vector2.DOWN
    else:
        direction = Vector2.ZERO

    return direction

# Function to check if player is moving
# Return: bool
static func is_movement_input() -> bool:
    if direction == Vector2.ZERO:
        return false
    else:
        return true

# Function to check if player is using tool
# Return: bool
static func use_tool() -> bool:
    var use_tool_value: bool = Input.is_action_just_pressed("basic_attack")

    return use_tool_value

# Function to check if player is using dash
# Return: bool
static func use_daash() -> bool:
    var use_dash_value: bool = Input.is_action_just_pressed("dash")

    return use_dash_value