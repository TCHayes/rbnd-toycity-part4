require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  def self.create(opts={})
  	@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  	CSV.open(@data_path, "a+") do |csv|
  		csv << [@id, opts[:brand], opts[:name], opts[:price]]
  		#Not sure if @id is working properly yet.
  	end
  	Product.new(opts={}) #Perhaps this should be called at the beginning of method, then returned here.
  end
  
  def self.all
  	return [] #Silly initial pass.
  end
end