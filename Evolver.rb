# WARNING: I have never even read `On the Origin of Species` so do not mistake
# this horrible code to be anything like what happens in nature.

class Evolver

  attr_reader :population
  attr_accessor :population_size, :mutation_probability, :breed_probability

  def initialize( klass )
    @entity = klass
    @population = []
    @population_size = 1000
    @mutation_probability = 0.01
    @breed_probability = 0.25
  end

  def setup
    @population_size.times do |i|
      @population << @entity.random
    end
  end

  def advance
    @population.each do |subject|
      if rand() <= @mutation_probability
        subject.mutate
      end
    end

    newborns = []
    @population.each do |subject|
      if rand() <= @breed_probability
        newborns << subject.breed( @population[rand(population.length)] )
      end
    end

    # Limit the number of newborns to at most 1/4 of the population size.
    if newborns.length * 4 > @population.length
      newborns.shuffle!
      newborns = newborns.first( @population.length / 4 )
    end

    # Select a random half of the population to be candidates for dying.
    killed = @population.shuffle.first( @population.length / 2 )
    # Sort them by goodness value in increasing order.
    killed.sort! do |a,b|
      if a.goodness < b.goodness
        -1
      elsif b.goodness > a.goodness
        1
      else
        0
      end
    end

    # Replace the weakest death candidates with the newborns.
    newborns.each_with_index do |subj,k|
      idx = @population.index( killed[k] )
      @population[idx] = subj
    end
  end

  def best
    @population.inject do |a,b|
      ( a.goodness > b.goodness ) ? a : b
    end
  end

  def worst
    @population.inject do |a,b|
      ( a.goodness > b.goodness ) ? b : a
    end
  end

end
