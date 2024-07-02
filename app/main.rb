class MyGame
  attr_gtk

  def tick
    defaults
    calc
    render
  end

  private

  def defaults
    state.y ||= 201
  end

  def calc
    if inputs.keyboard.up
      state.y += 5
    end
  end

  def render
    outputs.solids << {x: 0, y: 200, w: 1280, h: 20}
    outputs.sprites << {x: 0, y: state.y, w: 100, h: 100, path: 'sprites/mine/adventurer-attack1-00.png'}
  end
end

def tick args
  $game ||= MyGame.new
  $game.args = args
  $game.tick
end

$game = nil
