class MyGame
  attr_gtk

  def tick
    defaults
    calc
    render
  end

  private

  def defaults
    state.rotation ||= 0
    state.x ||= 576
    state.y ||= 0
  end

  def calc
    if inputs.mouse.click
      state.x = inputs.mouse.click.point.x - 64
      state.y = inputs.mouse.click.point.y - 50
    end
  end

  def render
    outputs.labels << {x: 580, y: 400, text: 'Hello World!'}
    outputs.sprites << {x: state.x, y: state.y, w: 128, h: 101, path: 'dragonruby.png', angle: state.rotation}
    state.rotation -= 1
  end
end

def tick args
  $game ||= MyGame.new
  $game.args = args
  $game.tick
end

$game = nil
