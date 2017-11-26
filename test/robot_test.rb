require "test_helper"

class RobotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Robot::VERSION
  end

  def test_execute_a_list_of_instructions
    state = ::Robot::State.new
    instructions = [
      ::Robot::Commands.method(:place),
      ::Robot::Commands.method(:move),
      ::Robot::Commands.method(:move),
      ::Robot::Commands.method(:right),
      ::Robot::Commands.method(:move),
      ::Robot::Commands.method(:report)
    ]
    args_list = [
      {x: 0, y: 0, f: 'N'}
    ]
    new_state = ::Robot.execute(state, instructions, args_list)
    refute_equal state, new_state
    assert_equal 1, new_state.x
    assert_equal 2, new_state.y
    assert_equal 'E', Robot::Commands.direction(new_state.angle)
  end
end
