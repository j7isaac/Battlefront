# Battlefront
## A battle simulation app.

This app is build on Ruby on Rails with a Postgresql database.

The battle algorithm works as follows:

* Random army is chosen to initiate attack
```battle_armies = [Army.find(army_a), Army.find(army_b)]```

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

