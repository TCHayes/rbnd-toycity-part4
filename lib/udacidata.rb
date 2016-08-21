require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

@@data_path = "../data/data.csv"

  def self.create(**opts)
    new_item = self.new(**opts)
    # Still need to check if id already in database before adding...
    CSV::open(@@data_path, "a+") do |csv|
      # Ideally would alter this for use w/ Transaction and Customer classes:
      csv << [new_item.id, new_item.brand, new_item.name, new_item.price]
    end
    new_item
  end
  
  def self.all
    products = []
    data_array = CSV.read(@@data_path)
    data_array.drop(1).each do |row|
      # Another modularity conflict:
      products << self.create(id: row[0], brand: row[1], name: row[2], price: row[3])
    end
    products
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

  def self.find(id)
    self.all.each.find { |product| product.id == id}
  end

  def self.destroy(id)
    data_array = CSV::read(@@data_path)
    deleted_row = data_array.delete_at(data_array.index { |row| row.first == id.to_s })
    CSV::open(@@data_path, "w+") do |csv|
      data_array.each do |row|
        csv << row
      end
    end
    self.new(id: deleted_row[0], brand: deleted_row[1], name: deleted_row[2], price: deleted_row[3])
  end

  def self.where(**opts)
    results = []
    if opts[:brand]
      results = self.all.select{ |product| product.brand == opts[:brand]}
    elsif opts[:name]
      results = self.all.select{ |product| product.name == opts[:name]}
    else
      #THROW ERROR
    end
    results
  end

  def update(**opts)
    @brand = opts[:brand] if opts[:brand]
    @price = opts[:price] if opts[:price]
    self
  end

  self.create_finder_methods('brand', 'name')

end