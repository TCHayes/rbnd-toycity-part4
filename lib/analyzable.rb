module Analyzable
  # Your code goes here!
  def average_price(products)
  	sum = 0.00
  	products.each do |product|
  		sum += product.price.to_f
  	end
  	result = sum/products.length
  	result.round(2)
  end

  def count_by_brand(products)
  	results = {}
  	products.each do |product|
  		results[product.brand] == nil ? results[product.brand] = 1 : results[product.brand] += 1
  	end
  	results
  end

  def count_by_name(products)
  	results = {}
  	products.each do |product|
  		results[product.name] == nil ? results[product.name] = 1 : results[product.name] += 1
  	end
  	results
  end

  def print_report(products)
  	report = ''
  	report << "Average Price: $#{average_price(products)}\n"
  	report << "\n"
  	report << "Inventory by Brand:\n"
  	# Brand Info
  	count_by_brand(products).each do |key, value|
  		report << "    - #{key}: #{value}\n"
  	end
  	report << "\n"
  	report << "Inventory by Name:\n"
  	# Name Info
  	count_by_name(products).each do |key, value|
  		report << "    - #{key.capitalize}: #{value}\n"
  	end
  	report
  end
end