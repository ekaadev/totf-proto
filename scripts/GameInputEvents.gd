class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
    var input_direction = Input.get_vector("left", "right", "up", "down")
    return input_direction

static func is_movement_input() -> bool:
    if direction == Vector2.ZERO:
        return false
    else:
        return true