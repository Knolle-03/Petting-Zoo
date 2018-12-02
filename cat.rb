# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'set'
require_relative 'pet'

# Class description
class Cat < Pet

  def initialize(name, birthday, *servants)
    super(name, birthday)
    @lives = 9
    @servants = servants.to_set
  end

  def demand_petting(servant)
    #get petted
  end

  def demand_feeding(servant)
    #get fed
  end
end