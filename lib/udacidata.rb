require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

@@products = []
@@data_path = "../data/data.csv"

  def self.create(opts={}) #This needs to be rewritten with modularity in mind. (Customer and Transaction classes will also inherit)
    new_product = Product.new(brand: opts[:brand], name: opts[:name], price: opts[:price])
    @@products << new_product
    #Still need to check if id already in database before adding...
    CSV.open(@@data_path, "a+") do |csv|
      csv << [new_product.id, opts[:brand], opts[:name], opts[:price]]
    end
    new_product    
  end
  
  def self.all
    @@products
  end

  def self.first(amount = 1)
    if amount == 1
      @@products.first
    else
      @@products.first(amount)
    end
  end

  def self.last(amount = 1)
    if amount == 1
      @@products.last
    else
      @@products.last(amount)
    end
  end
end