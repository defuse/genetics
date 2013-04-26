class Weasel
  attr_reader :str

  ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
  TARGET = "METHINKS IT IS LIKE A WEASEL"

  def self.random
    str = ""
    TARGET.length.times do |i|
      str << ALPHABET[rand(ALPHABET.length)]
    end
    return Weasel.new( str )
  end

  def initialize( str )
    @str = str
  end

  def mutate
    @str[rand(@str.length)] = ALPHABET[rand(ALPHABET.length)]
  end

  def breed( organism )
    str = ""
    TARGET.length.times do |i|
      if rand() < 0.5
        str << @str[i]
      else
        str << organism.str[i]
      end
    end
    return Weasel.new( str )
  end

  def goodness
    hamming = 0
    0.upto( @str.length - 1 ) do |i|
      hamming += (@str[i].ord ^ TARGET[i].ord).to_s(2).count("1")
    end
    return -hamming
  end

  def perfect?
    self.goodness == 0
  end

  def to_s
    @str
  end

end
