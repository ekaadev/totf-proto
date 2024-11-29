extends EnemyState

# BEAST DEATH STATE

# on enter function
# play the death animation
# wait for the animation to finish
# play the boss slained animation
# wait for the animation to finish
# queue free the owner
func enter():
    super.enter()
    animation_player.play("death")
    await animation_player.animation_finished
    animation_player.play("boss_slained")
    await animation_player.animation_finished
    owner.queue_free()