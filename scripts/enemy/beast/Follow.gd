extends EnemyState

# BEAST FOLLOW STATE

@onready var direction: Vector2
    
# process function
# update the animation based on the player direction
func _process(_delta: float) -> void:
	direction = owner.direction
	update_animation()

func update_animation():
    # Compare X and Y differences to determine primary direction
    var x_diff = abs(direction.x)
    var y_diff = abs(direction.y)
    
    # Check which direction has the greatest difference
    # and play the corresponding animation
    if x_diff > y_diff:
        # Horizontal movement is primary
        if direction.x < 0:
            animation_player.play("move_lr")
        else:
            animation_player.play("move_lr")
    else:
        # Vertical movement is primary
        if player.position.y < owner.position.y:
            # Player is above beast
            animation_player.play("move_up")
        else:
            # Player is below beast
            animation_player.play("move_down")

# on enter function
# set physics process to true
# set process to true
# update the animation
func enter():
	super.enter()
	owner.set_physics_process(true)
	set_process(true)
	update_animation()

# on exit function
# set physics process to false
# set process to false
func exit():
	super.exit()
	owner.set_physics_process(false)
	set_process(false)

# on next transitions function
# if the player is close to the beast, emit the spike attack transition
# beacuse beast direection refference is the player position
func transition():
    var distance = owner.direction.length()
    var player_current_state = owner.get_player_state_machine()

    if player_current_state.current_node_state_name == "death":
        get_parent().change_state("Death")

    if distance < 80 and player_current_state.current_node_state_name != "death":
        get_parent().change_state("SpikeAttack")
