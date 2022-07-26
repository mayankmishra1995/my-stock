class Item < ActiveRecord::Base

	validates :name,  presence: true
	# An item will either be in listed OR delisted state. 
	# When a file is uploaded and a record is created/ updated, the record must be in 'listed' state
	# If the user syncronizes their inventory then any item that's not present in the file must be moved to "delisted" state
	STATE_OPTIONS = %w(delisted listed)
  	validates :state, :inclusion => {:in => STATE_OPTIONS, message: "Expecting value of state is in #{STATE_OPTIONS} but got '%{value}'."}
  	validates :weight, numericality: true
  	validates :price, numericality: true

	# Use Case - Item.import(file)
	# Description - Used to import items from an csv file and save that into database
	# @param [file] file <file should be in csv format>
	# @return nil
	def self.import(file)
		return if file.blank?
		# TODO: 
		# 1. Sample file used here has three columns with following headers
		# 	- Name
		# 	- Weight
		# 	- Price
		# 	Currently it supports single price column and it represents (total price of item)
		# 	As a user, I should be able to upload a file with "Price per unit" (Total Price/ weight) OR "Total Price" OR both and it should save the record's price accordingly
		# 2. As a user, I should be able to update a record's price or weight by reuploading the file post correction. 
		# 3. As a user, I should be able to syncronize my inventory OR upload just the updates (make use of states)

		changeable_attrs = %w[weight price price_per_weight]
		CSV.foreach(file.path, headers: true) do |row|
			row_hash = row.to_hash
			# row_hash["state"] = "listed"
			item = Item.find_or_initialize_by(name: row_hash["name"])

			changeable_attrs.each { |attributes| item.send("#{attributes}=", row_hash[attributes])}
			#checking old records with persisted and assigning delisted
			item.state = item.persisted? && (item.changed & changeable_attrs).any? ? 'delisted' : 'listed'
			item.save!
			
			# Item.create! row_hash
		end
	end
end
