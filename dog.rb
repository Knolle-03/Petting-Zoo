# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require_relative 'pet'

# Class description
class Dog < Pet
  attr_reader :owner
  protected :owner

  def initialize(name, birthday, owner)
    raise ArgumentError, 'Owner must be of type Person' unless owner.is_a?(Person)

    super(name, birthday)
    @owner = owner
    @owner.add_pet(self)
  end

  def ==(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@name, @birthday, @lives, @owner] == [other.name, other.birthday, other.lives, other.owner]
  end

  def hash
    prime = 31
    result = 0
    result = prime * result + (@name.nil? ? 0 : @name.hash)
    result = prime * result + (@birthday.nil? ? 0 : @birthday.hash)
    result = prime * result + (@lives.nil? ? 0 : @lives.hash)
    prime * result + (@owner.nil? ? 0 : @owner.hash)
  end

  def eql?(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@name, @birthday, @lives, @owner] == [other.name, other.birthday, other.lives, other.owner]
  end
end