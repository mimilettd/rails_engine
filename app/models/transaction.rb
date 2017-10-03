class Transaction < ApplicationRecord
  belongs_to :invoice, required: false
end
