require 'comparable'

class Pet
  include(Comparable)
  def initialize(name, birthday)
    @name = name
    @birthday = birthday
    @lives = 1
  end

  def attack(target)
    #attack a another cat
  end

  def ==(other)

  end
end