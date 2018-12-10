# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'date'
require_relative 'deceased_error'

# Class description
class Pet
  attr_reader :name, :birthday, :lives
  protected :name, :birthday, :lives

  def initialize(name, birthday)
    raise ArgumentError, 'Birthday must be of type Date' unless birthday.is_a?(Date)

    @name = name
    @birthday = birthday
    @lives = 1
  end

  def attack(target)
    raise DeceasedError unless alive?
    raise ArgumentError, 'Only other pets can be attacked.' unless target.is_a?(Pet)

    target.get_attacked(self)

  end

  def get_attacked(attacker)
    if !alive?
      puts "#{self} is already dead. #{attacker} withdraws."
      false
    elsif attacker.equal?(self)
      puts "#{self} won't hit itself."
      false
    elsif is_a?(Cat) && attacker.is_a?(Dog)
      puts "#{self} tells #{attacker} to fuck off."
      false
    else
      @lives -= 1
      puts "#{self} gets attacked by #{attacker}."
      puts "#{self} dies." if lives.zero?
      true
    end
  end

  def alive?
    @lives > 0
  end

  def to_s
    @name.to_s
  end
end

