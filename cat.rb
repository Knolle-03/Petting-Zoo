# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'set'
require_relative 'pet'
require_relative 'person'

# Class description
class Cat < Pet



  def initialize(name, birthday, *servants)
    super(name, birthday)
    @lives = 9
    @servants = servants.to_set
  end

  def demand_petting(servant)
    raise DeceasedError unless alive?

    @servants.include?(servant) ? servant.pet_pet(self) : false
  end

  def demand_feeding(servant)
    raise DeceasedError unless alive?

    @servants.include?(servant) ? servant.feed_pet(self) : false
  end

  def add_servant(servant)
    raise ArgumentError, 'Argument is not a Person' unless servant.is_a?(Person)
    raise DeceasedError unless alive?

    @servants << servant
    puts "From now on #{self} demands #{servant}'s services'"
  end

  def remove_servant(servant)
    raise ArgumentError, 'Argument is not a Person' unless servant.is_a?(Person)

    if @servants.include?(servant)
      @servants.delete(servant)
      puts "#{self} no longer requires #{servant}'s services and sets him free."
    else
      puts "#{servant} is not a servant of #{self}"
    end
  end

  def servant?(servant)
    @servants.include?(servant)
  end

  def list_servants
    @servants.to_a.join(', ')
  end

  def lives_left
    puts "#{self} has #{@lives} #{@lives == 1 ? 'life' : 'lives'} left."
  end
end
