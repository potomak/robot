require "test_helper"

class StateTest < Minitest::Test
  def test_not_initialized
    state = ::Robot::State.new
    assert !state.initialized?
  end

  def test_initialized
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    assert state.initialized?
  end

  def test_not_valid
    state = ::Robot::State.new
    state.x = 0
    state.y = 6
    state.angle = Math::PI
    assert !state.valid?
  end

  def test_valid
    state = ::Robot::State.new
    state.x = 0
    state.y = 0
    state.angle = Math::PI
    assert state.valid?
  end

  def test_dup
    state = ::Robot::State.new
    state.x = 12
    state.y = 23
    state.angle = Math::PI
    new_state = state.dup
    new_state.x = 34
    new_state.y = 45
    new_state.angle = Math::PI * 2
    assert state.x != new_state.x
    assert state.y != new_state.y
    assert state.angle != new_state.angle
  end
end
