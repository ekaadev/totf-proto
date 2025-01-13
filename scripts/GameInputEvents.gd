class_name GameInputEvents

# Direction for player movement
static var direction: Vector2

# Function to get player movement input
# Player cant move diagonally
# Return: Vector2
static func movement_input() -> Vector2:
    direction = Input.get_vector("left", "right", "up", "down")

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

static func use_slash() -> bool:
    var use_slash_value: bool = Input.is_action_just_pressed("slash_attack")

    return use_slash_value

# Function to check if player is using dash
# Return: bool
static func use_dash() -> bool:
    var use_dash_value: bool = Input.is_action_just_pressed("dash")

    return use_dash_value