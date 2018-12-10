# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require_relative 'pet'

# Inherits from the Pet class.
# In initialize it is made sure that each dog has an owner.
# Since dogs apparently can't do stuff it doesn't have any extra methods.
class Dog < Pet
  attr_reader :owner
  protected :owner

  def initialize(name, birthday, owner)
    raise PersonError unless owner.is_a?(Person)

    super(name, birthday)
    @owner = owner
    @owner.add_pet(self)
  end
end

