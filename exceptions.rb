# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

# Several subclasses of ArgumentError.
# These are used to raise errors if a given argument isn't valid for a specific method.
class DeceasedError < ArgumentError
  def to_s
    'Dead animals cannot do stuff.'
  end
end

class PetError < ArgumentError
  def to_s
    'Argument must be a Pet object.'
  end
end

class PersonError < ArgumentError
  def to_s
    'Argument must be a Person object.'
  end
end

class CatError < ArgumentError
  def to_s
    'Argument must be a Cat object.'
  end
end

class BirthdayError < ArgumentError
  def to_s
    'Argument must be of typ Date.'
  end
end
