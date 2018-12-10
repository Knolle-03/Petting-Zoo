# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'date'
require_relative 'exceptions'

# The pet class from which cats and dogs inherit. It handles the attack methods
# and gives the possibility to check if a Pet is alive.
class Pet
  attr_reader :name, :birthday, :lives
  protected :name, :birthday, :lives

  def initialize(name, birthday)
    raise BirthdayError unless birthday.is_a?(Date)

    @name = name
    @birthday = birthday
    @lives = 1
  end

  def attack(target)
    raise DeceasedError unless alive?
    raise PetError unless target.is_a?(Pet)

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

