class_name GameInputEvents

static var direction: Vector2

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

static func is_movement_input() -> bool:
    if direction == Vector2.ZERO:
        return false
    else:
        return true

static func use_tool() -> bool:
    var use_tool_value: bool = Input.is_action_just_pressed("basic_attack")

    return use_tool_value