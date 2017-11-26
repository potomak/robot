require 'ostruct'
require 'forwardable'

module Robot
  class State
    attr_accessor :angle

    extend Forwardable
    def_delegators :@pos, :x, :y, :x=, :y=

    def initialize
      @pos = OpenStruct.new(x: nil, y: nil)
    end

    def initialized?
      x && y && angle
    end

    def valid?
      x > -1 && x < 6 && y > -1 && y < 6
    end

    def initialize_copy(other)
      @pos = OpenStruct.new(x: other.x, y: other.y)
    end

    def ==(other)
      x == other.x && y == other.y && angle == other.angle
    end
  end
end
