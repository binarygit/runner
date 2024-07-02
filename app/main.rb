class MyGame
  attr_gtk

  def tick
    defaults
    calc
    render
    input
  end

  private

  def defaults
    state.gravity = -0.3
    state.player.y ||= 201
    state.player.dy ||= 0
    state.player_jump_power           = 5
    state.player_jump_power_duration  = 10
    state.player.falling = false
  end

  def calc
    # player has landed on the platform
    collision = state.player.y <= 200
    if collision && state.player.dy <= 0
      state.player.falling = false
      state.player.jumped_at = nil
    else
      state.player.y += state.player.dy
      state.player.dy += state.gravity
    end
  end

  def render
    outputs.solids << {x: 0, y: 200, w: 1280, h: 20}
    render_sagar
  end

  def input
    if inputs.keyboard.space
     state.player.jumped_at ||= state.tick_count

     
      if state.player.jumped_at.elapsed_time < state.player_jump_power_duration && !state.player.falling
       state.player.dy = state.player_jump_power
      end
    end

    if inputs.keyboard.key_up.space
     state.player.falling = true
     outputs.sounds << "sounds/jump_10.wav"
    end
  end

  def render_sagar
    outputs.sprites << {x: 0, y: state.player.y, w: 100, h: 100, path: "sprites/mine/adventurer-run-0#{sprite_index}.png"}
  end

  def sprite_index
    Numeric.frame_index count: 6,
      start_at: 0,
      hold_for: 6,
      repeat: true,
      repeat_index: 0,
      tick_count_override: Kernel.tick_count

  end
end

def tick args
  $game ||= MyGame.new
  $game.args = args
  $game.tick
end

$game = nil
