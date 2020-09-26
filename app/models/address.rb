class Address < ApplicationRecord
	belongs_to :customer, optional: true

	validates :name, presence: true
	validates :postal_code, presence: true
	validates :address, presence: true
end
