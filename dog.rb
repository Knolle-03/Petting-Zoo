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
end

