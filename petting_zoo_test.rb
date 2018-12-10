# Aufgabe a08
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'test/unit'
require_relative 'dog'
require_relative 'person'
require_relative 'cat'

# Class description
class PettingZooTest < Test::Unit::TestCase

  def setup
    @person_with_pets = Person.new('Franz')
    @person_without_pets = Person.new('Gert')

    @cat1 = Cat.new('Horst', Date.new(1932, 12, 7))
    @cat2 = Cat.new('Dieter', Date.new(1876, 2, 1))
    @dead_cat = Cat.new('Hermann', Date.new(1933, 9, 5))
    9.times { @cat1.attack(@dead_cat) }

    @dog1 = Dog.new('Pete', Date.new(2003, 3, 3), @person_with_pets)
    @dog2 = Dog.new('Quinn', Date.new(2003, 3, 3), @person_with_pets)
    @dead_dog = Dog.new('Manny', Date.new(1999, 9, 9), @person_with_pets)
    @dog1.attack(@dead_dog)
    @cat1.add_servant(@person_with_pets)
  end

  def test_create_new_dogs
    assert_raise(ArgumentError.new('Birthday must be of type Date')) { Dog.new('Name', '1.1.1999', @person_with_pets) }
    assert_raise(ArgumentError.new('Owner must be of type Person')) { Dog.new('Name', Date.new(1999, 1, 1), 'Person') }
    assert_nothing_raised {Dog.new('Name', Date.new, Person.new('name')) }
  end

  def test_assign_dogs_to_owner
    assert_true(@person_without_pets.list_pets.empty?)
    Dog.new('Jupp', Date.new, @person_without_pets)
    assert_false(@person_without_pets.list_pets.empty?)
    Dog.new('Drew', Date.new, @person_without_pets)
    assert_equal('Jupp, Drew', @person_without_pets.list_pets)
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
    assert_false(@dog1.attack(@cat1))
    assert_true(@cat1.alive?)
    # living dog -> person (i.e. non-pet)
    assert_raise(ArgumentError.new('Only other pets can be attacked.')) {@dog1.attack(@person_with_pets)}
    # dead dog -> anything
    assert_raise(DeceasedError) { @dog2.attack(@dog1) }
  end

  def test_cat_attacks
    # living cat -> living cat
    assert_true(@cat1.attack(@cat2))
    # living cat -> dead cat
    assert_false(@cat1.attack(@dead_cat))
    # living cat -> itself
    assert_false(@cat1.attack(@cat1))
    # living cat -> living dog
    assert_true(@cat1.attack(@dog1))
    # living cat -> dead dog
    assert_false(@cat1.attack(@dog1))
    # living cat -> person (i.e. non-pet)
    assert_raise(ArgumentError) { @cat1.attack(@person_with_pets) }
    # dead cat -> anything
    assert_raise(DeceasedError) { @dead_cat.attack(@cat1) }
  end

  def test_person_pets_cat
    # servant -> living cat
    assert_true(@person_with_pets.pet_pet(@cat1))
    # servant -> dead cat
    assert_false(@person_with_pets.pet_pet(@dead_cat))
    # non-servant -> living cat
    assert_false(@person_without_pets.pet_pet(@cat2))
    # non-servant -> dead cat
    assert_false(@person_without_pets.pet_pet(@dead_cat))
  end

  def test_person_feeds_cat
    # servant -> living cat
    assert_true(@person_with_pets.feed_pet(@cat1))
    # servant -> dead cat
    assert_false(@person_with_pets.feed_pet(@dead_cat))
    # non-servant -> living cat
    assert_false(@person_without_pets.feed_pet(@cat2))
    # non-servant -> dead cat
    assert_false(@person_without_pets.feed_pet(@dead_cat))
  end

  def test_cat_demand_petting
    # living cat -> servant
    assert_true(@cat1.demand_petting(@person_with_pets))
    # dead cat -> servant
    assert_raise(DeceasedError) { @dead_cat.demand_petting(@person_with_pets) }
    # living cat -> non-servant
    assert_false(@cat1.demand_petting(@person_without_pets))
    # dead cat -> non-servant
    assert_raise(DeceasedError) { @dead_cat.demand_petting(@person_without_pets) }
  end

  def test_cat_demand_feeding
    # living cat -> servant
    assert_true(@cat1.demand_feeding(@person_with_pets))
    # dead cat -> servant
    assert_raise(DeceasedError) { @dead_cat.demand_feeding(@person_with_pets) }
    # living cat -> non-servant
    assert_false(@cat1.demand_feeding(@person_without_pets))
    # dead cat -> non-servant
    assert_raise(DeceasedError) { @dead_cat.demand_feeding(@person_without_pets) }
  end

  def test_person_pets_dogs
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

