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

  module_function :execute
end
