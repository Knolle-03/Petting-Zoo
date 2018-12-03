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
    raise DeceasedError unless self.alive?
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
    elsif self.is_a?(Cat) && attacker.is_a?(Dog)
      puts "#{self} tells #{attacker} to fuck off."
      false
    else
      @lives -= 1
      puts "#{self} gets attacked by #{attacker}."
      if self.lives.zero?
        puts "#{self} dies."
      end
      true
    end

  end

  def get_fed(source)
    if alive?
      puts "#{self} gets fed by #{source}. Yummy."
      true
    else
      puts "#{self} won't eat anything. Ever Again."
      false
    end
  end

  def get_petted(source)
    if alive?
      puts "#{self} gets petted by #{source} and feels delighted."
      true
    else
      puts "#{self} gets petted by #{source}, but feels nothing."
      false
    end
  end

  def alive?
    @lives > 0 ? true : false
  end

  def to_s
    @name.to_s
  end
=begin
  def ==(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@name, @birthday, @lives] == [other.name, other.birthday, other.lives]
  end

  def hash
    prime = 31
    result = 0
    result = prime * result + (@name.nil? ? 0 : @name.hash)
    result = prime * result + (@birthday.nil? ? 0 : @birthday.hash)
    prime * result + (@lives.nil? ? 0 : @lives.hash)
  end

  def eql?(other)
    return false if other.nil?
    return true if self.equal?(other)
    return false unless self.class == other.class
    [@name, @birthday, @lives] == [other.name, other.birthday, other.lives]
  end
=end
end
