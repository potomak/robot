module Robot
  module Commands
    ANGLES = {
      'EAST' => 0,
      'NORTH' => Math::PI / 2,
      'WEST' => Math::PI,
      'SOUTH' => 3 * Math::PI / 2
    }

    def move(state, args={})
      return state unless state.valid?
      new_state = state.dup
      new_state.x += Math::cos(new_state.angle).round
      new_state.y += Math::sin(new_state.angle).round
      new_state
    end

    def left(state, args={})
      return state unless state.valid?
      new_state = state.dup
      new_state.angle += Math::PI / 2
      new_state
    end

    def right(state, args={})
      return state unless state.valid?
      new_state = state.dup
      new_state.angle -= Math::PI / 2
      new_state
    end

    def place(state, args={})
      new_state = state.dup
      new_state.x = args[:x]
      new_state.y = args[:y]
      new_state.angle = ANGLES[args[:f]]
      new_state
    end

    def report(state, args={})
      if !state.initialized?
        puts "uninizialized"
        return state
      end
      puts "#{state.x},#{state.y},#{direction(state.angle)}"
      state
    end

    def direction(angle)
      case angle / (Math::PI / 2) % 4
      when 0; return 'EAST'
      when 1; return 'NORTH'
      when 2; return 'WEST'
      when 3; return 'SOUTH'
      end
    end

    module_function :move, :left, :right, :place, :report, :direction
  end
end
