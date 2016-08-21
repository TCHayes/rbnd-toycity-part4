class Module
    def create_finder_methods(*attributes)
    	attributes.each do |attribute|
	    	method_text = %Q{
	    		def self.find_by_#{attribute}(attr_input)
	    			self.all.each.find { |product| product.#{attribute} == attr_input }
				end}
			class_eval(method_text)
		end
	end
end