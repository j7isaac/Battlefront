# Battlefront
A battle simulation app.
---

This app is build on Ruby on Rails with a Postgresql database.

The battle algorithm works as follows:

* Random army is chosen to initiate attack
```
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
```
* Then a loop is created to make attacks until an army is defeated.
```
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
```
* Each army's attack method selects a soldier at random to attack a random target.
```
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
```
* Each soldier is created with a random amount of luck. This random amount is used later to affect attack and defense.
```
  def infantry_hash(id)
    { id: id, type: 'foot_soldier', health: 100, power: 75, defense: 15, luck: rand(10) }
  end
```

The battle data that is displayed after a battle works as follows:
* A count is made for each type of soldier the surviving army has.
```
  def infantry_remaining
    soldiers_alive.count { |soldier| soldier[:type] == 'foot_soldier' }
  end
```
* The soldier count is then used to calculate overall damage sustained for that army.
```
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
```
* These calculations are then display on the page.
```
<div class="flex-container">
  <div class='box2'>
    <h1><%= "#{@battle.battle!.name.capitalize} is Victorious!" %></h1>
    <h3>Battle Report</h3>
    <hr>
    <p>
      <%= "#{@battle.victor.name.capitalize} army remained with:"%><br>
      <%= "#{@battle.victor.infantry_remaining} out of #{@battle.victor.infantry} Infantry units remaining"%><br>
      <%= "#{@battle.victor.archers_remaining} out of #{@battle.victor.archers} Archer units remaining"%><br>
      <%= "#{@battle.victor.knights_remaining} out of #{@battle.victor.knights} Knight units remaining"%><br>
      <%= "#{@battle.victor.damage_percentage} Damage Sustained"%>
    </p>
    <%= link_to "New Battle", root_path, class: "btn" %>
  </div>
</div>
```

Please create your own armies, battle them and enjoy!




