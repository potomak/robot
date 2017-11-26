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
      [x, y, angle].all?
    end

    def valid?
      x > -1 && x < 6 && y > -1 && y < 6
    end
  end
end
