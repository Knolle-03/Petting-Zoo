# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

# Class description
class DeceasedError < ArgumentError
  def to_s
    'Dead animals cannot do stuff.'
  end
end