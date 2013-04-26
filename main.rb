require './Evolver.rb'
require './Weasel.rb'

evolver = Evolver.new( Weasel )
evolver.setup

i = 0
while 1
  best = evolver.best
  worst = evolver.worst
  print "#{best} -- vs. -- #{worst} (Gen: #{i}) \r"
  break if best.perfect?
  evolver.advance
  i += 1
end
puts
