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
    args.outputs.labels << [580, 400, 'Hello World!']
    args.outputs.sprites << [args.state.x, args.state.y, 128, 101, 'dragonruby.png', args.state.rotation]
    args.state.rotation -= 1
  end
end

def tick args
  $game ||= MyGame.new
  $game.args = args
  $game.tick
end

$game = nil
