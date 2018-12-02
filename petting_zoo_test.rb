# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'test/unit'
require_relative 'dog'
require_relative 'person'

# Class description
class PettingZooTest < Test::Unit::TestCase

  def setup
    #@pet1 = Pet.new('Alf', Date.new(2000, 1, 2))
    #@pet2 = Pet.new('Basti', Date.new(1923, 4, 5))

    @person_with_pets = Person.new('Franz')
    @person_without_pets = Person.new('Gert')

    @dog1 = Dog.new('Pete', Date.new(2003, 3, 3), @person_with_pets)
    @dog2 = Dog.new('Quinn', Date.new(2003, 3, 3), @person_with_pets)
    @dead_dog = Dog.new('Manny', Date.new(1999, 9, 9), @person_with_pets)
    @dog1.attack(@dead_dog)
  end

  def test_dog_identity
    assert_false(@dog1 == @dog2)
    assert_false(@dog1.eql?(@dog2))
    assert_true(@dog1 == Dog.new('Pete', Date.new(2003, 3, 3), @person_with_pets))
    assert_true(@dog1.eql?(Dog.new('Pete', Date.new(2003, 3, 3), @person_with_pets)))
        # pets are not equivalent to dogs
    assert_false(@dog1 == Pet.new('Pete', Date.new(2003, 3, 3)))
    assert_false(@dog1.eql?(Pet.new('Pete', Date.new(2003, 3, 3))))
    assert_false(Pet.new('Pete', Date.new(2003, 3, 3)) == @dog1)
    assert_false(Pet.new('Pete', Date.new(2003, 3, 3)).eql?(@dog1))
  end

  def test_create_new_dogs
    assert_raise(ArgumentError.new('Birthday must be of type Date')) { Dog.new('Name', '1.1.1999', @person_with_pets) }
    assert_raise(ArgumentError.new('Owner must be of type Person')) { Dog.new('Name', Date.new(1999, 1, 1), 'Person') }
    assert_nothing_raised {Dog.new('Name', Date.new, Person.new('name')) }
  end

  def test_assign_dogs_to_owner
    assert_true(@person_without_pets.pets.empty?)
    Dog.new('Jupp', Date.new, @person_without_pets)
    assert_false(@person_without_pets.pets.empty?)
    Dog.new('Drew', Date.new, @person_without_pets)
    assert_equal('Jupp, Drew', @person_without_pets.pets)
  end

  def test_dog_attacks
    assert_true(@dog2.alive?)
        # living dog -> living dog
    assert_true(@dog1.attack(@dog2))
    assert_false(@dog2.alive?)
        # living dog -> dead dog
    assert_false(@dog1.attack(@dog2))
        # living dog -> itself
    assert_false(@dog1.attack(@dog1))
        # living dog -> living cat
    #assert_true(@cat1.alive?)
    #assert_false(@dog1.attack(@cat1))
        # living dog -> person (i.e. non-pet)
    assert_raise(ArgumentError.new('Only other pets can be attacked.')) {@dog1.attack(@person_with_pets)}
        # dead dog -> anything
    assert_raise(DeceasedError) {@dog2.attack(@dog1)}
  end

  def test_cat_attacks
    # living cat -> living cat

    # living cat -> dead cat

    # living cat -> itself

    # living cat -> living dog

    # living cat -> dead dog

    # living cat -> person (i.e. non-pet)

    # dead cat -> anything

  end

  def test_person_pets_dogs
  assert_false(@dead_dog.alive?)
    # owner -> living dog
  assert_true(@person_with_pets.pet_pet(@dog1))
    # owner -> dead dog
  assert_false(@person_with_pets.pet_pet(@dead_dog))
    # non-owner -> living dog
  assert_true(@person_without_pets.pet_pet(@dog1))
    # non-owner -> dead dog
  assert_false(@person_without_pets.pet_pet(@dead_dog))
  end

  def test_person_feeds_dogs
    assert_false(@dead_dog.alive?)
    # owner -> living dog
    assert_true(@person_with_pets.feed_pet(@dog1))
    # owner -> dead dog
    assert_false(@person_with_pets.feed_pet(@dead_dog))
    # non-owner -> living dog
    assert_true(@person_without_pets.feed_pet(@dog1))
    # non-owner -> dead dog
    assert_false(@person_without_pets.feed_pet(@dead_dog))
  end
end
