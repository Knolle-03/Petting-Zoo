# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'set'

# Class description
class Person
  attr_reader :name, :pets
  protected :name, :pets

  def initialize(name)
    @name = name
    @pets = Set[]
  end

  def pet_pet(target)
    raise ArgumentError, 'Argument must be of type Pet.' unless target.is_a?(Pet)

    target.get_petted(self)
  end

  def feed_pet(target)
    raise ArgumentError, 'Argument must be of type Pet.' unless target.is_a?(Pet)

    target.get_fed(self)
  end

  def add_pet(pet)
    raise ArgumentError, 'Argument must be of type Pet.' unless pet.is_a?(Pet)

    @pets << pet
    self
  end

  def to_s
    @name.to_s
  end

  def pets
    @pets.to_a.join(', ')
  end

  def ==(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@name, @pets] == [other.name, other.pets]
  end

  def hash
    prime = 31
    result = 0
    result = prime * result + (@name.nil? ? 0 : @name.hash)
    prime * result + (@pets.nil? ? 0 : @pets.hash)
  end

  def eql?(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@name, @pets] == [other.name, other.pets]
  end
end
