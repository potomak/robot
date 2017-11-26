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

  def test_execute_missing_place
    state = ::Robot::State.new
    instructions = [
      ::Robot::Commands.method(:move)
    ]
    args_list = []
    new_state = ::Robot.execute(state, instructions, args_list)
    assert_equal state, new_state
  end

  def test_parse_valid_program
    expected_instructions = [
      ::Robot::Commands.method(:place),
      ::Robot::Commands.method(:move),
      ::Robot::Commands.method(:left),
      ::Robot::Commands.method(:right),
      ::Robot::Commands.method(:report)
    ]
    expected_args_list = [
      {x: 12, y: 23, f: 'N'},
      nil,
      nil,
      nil,
      nil
    ]
    program = File.open('test/fixtures/valid_program.txt').read
    instructions, args_list = ::Robot.parse(program)
    assert_equal expected_instructions, instructions
    assert_equal expected_args_list, args_list
  end

  def test_parse_invalid_program
    program = "INVALID"
    assert_raises RuntimeError, 'Command not supported: INVALID' do
      ::Robot.parse(program)
    end
  end

  def test_parse_missing_arguments
    program = "PLACE 12"
    assert_raises RuntimeError, 'Missing arguments' do
      ::Robot.parse(program)
    end
  end
end
