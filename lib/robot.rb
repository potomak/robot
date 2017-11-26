require "robot/version"
require "robot/state"
require "robot/commands"

module Robot
  def execute(initial_state, instructions, args_list)
    valid_instructions = instructions.zip(args_list).map do |instruction, args|
      Proc.new do |state|
        new_state = instruction[state, args]
        new_state.valid? ? new_state : state
      end
    end

    valid_instructions.reduce(initial_state) do |state, instruction|
      instruction[state]
    end
  end

  def parse(string)
    string.split("\n").map(&:strip).map do |command_string|
      instruction, *args = command_string.split(" ").map(&:strip)
      case instruction
      when 'PLACE'
        x, y, f = args.join(" ").split(",").map(&:strip)
        raise 'Missing arguments' if !x || !y || !f
        [Commands.method(:place), {x: x.to_i, y: y.to_i, f: f}]
      when 'LEFT'
        [Commands.method(:left), nil]
      when 'RIGHT'
        [Commands.method(:right), nil]
      when 'MOVE'
        [Commands.method(:move), nil]
      when 'REPORT'
        [Commands.method(:report), nil]
      else
        raise "Command not supported: #{command_string}"
      end
    end.transpose
  end

  module_function :execute, :parse
end
