class Army < ActiveRecord::Base
  attr_reader :soldiers

  def infantry_hash(id)
    { id: id, type: 'foot_soldier', health: 100, power: 75, defense: 15, luck: rand(10) }
  end

  def archer_hash(id)
    { id: id, type: 'archer', health: 100, power: 40, defense: 30, luck: rand(18) }
  end

  def knight_hash(id)
    { id: id, type: 'knight', health: 100, power: 70, defense: 50, luck: rand(40) }
  end

  def build_army
    @soldiers = []
    infantry.times { |id| @soldiers << infantry_hash(id) }
    archers.times { |id| @soldiers << archer_hash(id) }
    knights.times { |id| @soldiers << knight_hash(id) }
    @soldiers
  end

  def attack(target)
    friendly = soldiers_alive.sample
    enemy = target.soldiers_alive.sample
    result = friendly[:power] + friendly[:luck] - enemy[:defense] - enemy[:luck]
    target.soldiers_alive[target.soldiers_alive.index(enemy)][:health] -= result unless result < 0
  end

  def soldiers_alive
    soldiers.select { |soldier| soldier[:health] > 0 }
  end
end
