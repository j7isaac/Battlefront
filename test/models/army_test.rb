require 'test_helper'

class ArmyTest < ActiveSupport::TestCase
  def setup
    @army1 = armies(:one)
    @army2 = armies(:two)
    @army1.build_army
    @army2.build_army
  end

  test 'should build the appropriate number of soldiers' do
    assert_equal 18, @army1.soldiers.count, 'Should be 9'
    assert_equal 4, @army2.soldiers.count, 'Should be 4'
  end

  test 'should properly update enemy @soldiers array' do
    @army1.attack(@army2)
    assert_equal 1, @army2.soldiers_alive.count { |soldier| soldier[:health] < 100 }
  end

  test 'should find the corrct number of soldiers_alive' do
    assert_equal 4, @army2.soldiers_alive.count
  end
end
