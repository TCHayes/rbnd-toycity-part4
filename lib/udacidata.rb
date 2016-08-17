require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

@@data_path = "../data/data.csv"

  def self.create(opts={}) #This needs to be rewritten with modularity in mind. (Customer and Transaction classes will also inherit)
    new_product = Product.new(brand: opts[:brand], name: opts[:name], price: opts[:price])
    #Still need to check if id already in database before adding...
    CSV.open(@@data_path, "a+") do |csv|
      csv << [new_product.id, opts[:brand], opts[:name], opts[:price]]
    end
    new_product
  end
  
  def self.all
    @products = [] #Question: Should this array have the @ sign in front?
    data_array = CSV.read(@@data_path)
    data_array.drop(1).each do |row|
      @products << self.create(id: row[0], brand: row[1], name: row[2], price: row[3])
    end
    #@products.each {|product| puts product.id} #For testing to see IDs
    @products
  end

  def self.first(amount = 1)
    if amount == 1
      self.all.first
    else
      self.all.first(amount)
    end
  end

  def self.last(amount = 1)
    if amount == 1
      self.all.last
    else
      self.all.last(amount)
    end
  end
end