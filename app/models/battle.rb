class Battle < ActiveRecord::Base
  after_create :battle!

  def battle!
    battle_armies = [Army.find(army_a), Army.find(army_b)]
    @attack_initiator = battle_armies.sample
    battle_armies.delete(@attack_initiator)
    @other_army = battle_armies[0]

    @attack_initiator.build_army
    @other_army.build_army

    until defeat_has_occurred?
      @attack_initiator.attack(@other_army)
      break if defeat_has_occurred?
      @other_army.attack(@attack_initiator)
      break if defeat_has_occurred?
    end
    victor
  end

  def defeat_has_occurred?
    @attack_initiator.soldiers_alive.empty? || @other_army.soldiers_alive.empty?
  end

  def victor
    return @attack_initiator if @attack_initiator.soldiers_alive.count > 0
    return @other_army if @other_army.soldiers_alive.count > 0
  end
end
