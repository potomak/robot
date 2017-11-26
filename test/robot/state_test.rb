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
end
