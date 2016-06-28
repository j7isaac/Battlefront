class Army < ActiveRecord::Base
  attr_reader :soldiers

  # Create stats for each soldier type.
  def infantry_hash(id)
    { id: id, type: 'foot_soldier', health: 100, power: 75, defense: 15, luck: rand(10) }
  end

  def archer_hash(id)
    { id: id, type: 'archer', health: 100, power: 40, defense: 30, luck: rand(18) }
  end

  def knight_hash(id)
    { id: id, type: 'knight', health: 100, power: 70, defense: 50, luck: rand(40) }
  end

  # Create an array of soldiers based on the number for each type listed in the army object.
  def build_army
    @soldiers = []
    infantry.times { |id| @soldiers << infantry_hash(id) }
    archers.times { |id| @soldiers << archer_hash(id) }
    knights.times { |id| @soldiers << knight_hash(id) }
    @soldiers
  end

  # This method will be used to make the attacks.
  def attack(target)
    # Select a random friendly soldier and assign it to a variable
    friendly = soldiers_alive.sample
    # Select a random enemy soldier and assign it to a variable
    enemy = target.soldiers_alive.sample
    # Use statistics from both attackers to generate a damage amount
    result = friendly[:power] + friendly[:luck] - enemy[:defense] - enemy[:luck]
    # Use the damage amount to decrease the health of the target
    # Amounts < 0 will not be processed
    target.soldiers_alive[target.soldiers_alive.index(enemy)][:health] -= result unless result < 0
  end

  # Find all soldiers who still have health levels above 0
  def soldiers_alive
    soldiers.select { |soldier| soldier[:health] > 0 }
  end

  # Outputs a count of infantry units remaining
  def infantry_remaining
    soldiers_alive.count { |soldier| soldier[:type] == 'foot_soldier' }
  end

  # Outputs a count of archer units remaining
  def archers_remaining
    soldiers_alive.count { |soldier| soldier[:type] == 'archer' }
  end

  # Outputs a count of knight units remaining
  def knights_remaining
    soldiers_alive.count { |soldier| soldier[:type] == 'knight' }
  end

  # Calculates damage percentage
  def damage_percentage
    damage = soldiers.count * 100 - health_total
    fraction_to_percent(damage, (soldiers.count * 100))
  end

  # Creates an array of soldiers alive and sums their health
  def health_total
    soldiers_alive.map { |soldier| soldier[:health] }.inject(0) { |a, e| a + e }
  end

  # Converts a fraction to percentage
  def fraction_to_percent(a, b)
    (a.to_f / b.to_f * 100).round(2).to_s + '%'
  end
end
