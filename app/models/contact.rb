class Contact < ApplicationRecord
	validates_presence_of :name, presence: true, :message => "Can't be blank"
	validates_presence_of :email, presence: true, :message => "Can't be blank"
	validates_presence_of :birthdate, presence: true, :message => "Can't be blank"
	#Associations
	belongs_to :kind
	has_many :phones
	has_one :address

	#Nested Attributes
	accepts_nested_attributes_for :phones, allow_destroy: true
	accepts_nested_attributes_for :address
	


	def as_json(options={})
		h = super(options)
		h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
		h
	end

end
