class Phone < ApplicationRecord
  #Associations
  belongs_to :contact, optional: true
end
