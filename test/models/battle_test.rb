require 'test_helper'

class BattleTest < ActiveSupport::TestCase
  def setup
    @battle_1 = battles(:one)
  end

  test 'should output a victor of battle' do
    assert_equal 2, @battle_1.battle!.id
  end
end
