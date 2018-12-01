require_relative 'pet'

class Dog < Pet

  def initialize(name, birthday, owner)
    super(name, birthday)
    @owner = owner
  end

  def attack(target)
    # return if target.is_a(Cat)
    super(target)
    # hund töten
  end
end