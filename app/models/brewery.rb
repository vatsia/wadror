class Brewery < ActiveRecord::Base
  has_many :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beer #{beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed to year #{year}"
  end

  def to_s
    name
  end
end
