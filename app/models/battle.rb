class Battle < ActiveRecord::Base
  after_create :battle!

  # The method will create a loop of attacks until there is a victor
  def battle!
    # List the opposing armies
    battle_armies = [Army.find(army_a), Army.find(army_b)]
    # Assign a random army to a variable
    @attack_initiator = battle_armies.sample
    # Removed previous army from array
    battle_armies.delete(@attack_initiator)
    # Assign the remaining army to a variable
    @other_army = battle_armies[0]
    # Build soldier arrays for both armies
    @attack_initiator.build_army
    @other_army.build_army

    # Create a loop of continuous attacks until a defeat has occurred
    until defeat_has_occurred?
      # Attack initiator attacks other army first
      @attack_initiator.attack(@other_army)
      # Break the loop if a defeat has occurred
      break if defeat_has_occurred?
      # Other army counters
      @other_army.attack(@attack_initiator)
      # Checks for defeat and if so breaks loop
      break if defeat_has_occurred?
    end
    victor
  end

  # Checks if a defeat has occurred
  def defeat_has_occurred?
    @attack_initiator.soldiers_alive.empty? || @other_army.soldiers_alive.empty?
  end

  # Display the army that survives the battle
  def victor
    return @attack_initiator if @attack_initiator.soldiers_alive.count > 0
    return @other_army if @other_army.soldiers_alive.count > 0
  end
end
