require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  def self.create(**opts)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    new_item = self.new(**opts)
    unless id_exists?(opts[:id])
      CSV::open(@data_path, "a+") do |csv|
        # Ideally would alter this for use w/ Transaction and Customer classes:
        csv << [new_item.id, new_item.brand, new_item.name, new_item.price]
      end
    end
    new_item
  end
  
  def self.all
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    products = []
    data_array = CSV.read(@data_path)
    data_array.drop(1).each do |row|
      # Another modularity conflict:
      products << self.new(id: row[0], brand: row[1], name: row[2], price: row[3])
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
    result = self.all.each.find { |product| product.id == id}
    if result == nil
      raise ProductNotFoundError.new
    else
      result
    end
  end

  def self.destroy(id)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    data_array = CSV::read(@data_path)
    if data_array.index { |row| row.first == id.to_s } == nil
      raise ProductNotFoundError.new
    else
    deleted_row = data_array.delete_at(data_array.index { |row| row.first == id.to_s })
    CSV::open(@data_path, "w+") do |csv|
      data_array.each do |row|
        csv << row
      end
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
      raise UserInputError.new, "Where method only supports selecting by brand or name."
    end
    results
  end

  def update(**opts)
    @brand = opts[:brand] if opts[:brand]
    @price = opts[:price] if opts[:price]
    @name = opts[:name] if opts[:name]
    Product.destroy(@id)
    Product.create(id: @id, brand: @brand, name: @name, price: @price)
  end

  def self.id_exists?(id)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    data_array = CSV::read(@data_path)
    if data_array.any? { |row| row.first == id.to_s }
      true
    else
      false
    end
  end

  self.create_finder_methods('brand', 'name')

end