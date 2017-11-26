require "test_helper"

class CommandsTest < Minitest::Test
  def test_move
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    new_state = ::Robot::Commands.move(state)
    refute_equal state, new_state
    assert_equal(-1, new_state.x)
    assert_equal state.y, new_state.y
    assert_equal state.angle, new_state.angle
  end

  def test_move_not_initialized
    state = ::Robot::State.new
    new_state = ::Robot::Commands.move(state)
    assert_equal state, new_state
    assert !new_state.initialized?
  end

  def test_right
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    new_state = ::Robot::Commands.right(state)
    refute_equal state, new_state
    assert_equal state.x, new_state.x
    assert_equal state.y, new_state.y
    assert_equal(-1 * Math::PI / 2, new_state.angle - state.angle)
  end

  def test_right_not_initialized
    state = ::Robot::State.new
    new_state = ::Robot::Commands.right(state)
    assert_equal state, new_state
    assert !new_state.initialized?
  end

  def test_left
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    new_state = ::Robot::Commands.left(state)
    refute_equal state, new_state
    assert_equal state.x, new_state.x
    assert_equal state.y, new_state.y
    assert_equal Math::PI / 2, new_state.angle - state.angle
  end

  def test_left_not_initialized
    state = ::Robot::State.new
    new_state = ::Robot::Commands.left(state)
    assert_equal state, new_state
    assert !new_state.initialized?
  end

  def test_place
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    new_state = ::Robot::Commands.place(state, x: 12, y: 23, f: 'E')
    refute_equal state, new_state
    assert_equal 12, new_state.x
    assert_equal 23, new_state.y
    assert_equal 0, new_state.angle
  end

  def test_place_not_initialized
    state = ::Robot::State.new
    new_state = ::Robot::Commands.place(state, x: 12, y: 23, f: 'E')
    refute_equal state, new_state
    assert new_state.initialized?
    assert_equal 12, new_state.x
    assert_equal 23, new_state.y
    assert_equal 0, new_state.angle
  end

  def test_report
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    new_state = ::Robot::Commands.report(state)
    assert_equal state, new_state
  end

  def test_report_not_initialized
    state = ::Robot::State.new
    new_state = ::Robot::Commands.report(state)
    assert_equal state, new_state
    assert !new_state.initialized?
  end
end
