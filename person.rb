# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'set'
require_relative 'pet'

# The person class can add pets to its collection as long as they aren't cats.
# It can also pet and feed pet. If a person wants to pet or feed a cat it is
# firstly checked if the Person is one of its servants.
class Person
  attr_reader :name, :pets
  protected :name, :pets

  def initialize(name)
    @name = name
    @pets = Set[]
  end

  def pet_pet(pet)
    raise PetError unless pet.is_a?(Pet)

    if pet.is_a?(Cat)
      return false unless pet.servant?(self)
    end
    if pet.alive?
      puts "#{pet} gets fed by #{self}. Yummy."
      true
    else
      puts "#{pet} won't eat anything. Ever Again."
      false
    end
  end

  def feed_pet(pet)
    raise PetError unless pet.is_a?(Pet)

    if pet.is_a?(Cat)
      return false unless pet.servant?(self)
    end
    if pet.alive?
      puts "#{pet} gets petted by #{self} and feels delighted."
      true
    else
      puts "#{pet} gets petted by #{self}, but feels nothing."
      false
    end
  end

  def add_pet(pet)
    raise ArgumentError, 'A cat chooses its servants.' if pet.is_a?(Cat) && pet.alive?

    @pets << pet
    self
  end

  def to_s
    @name.to_s
  end

  def list_pets
    @pets.to_a.join(', ')
  end
end

