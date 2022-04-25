class GlAccount < ApplicationRecord
    has_many :transactions

    validates :name, presence: true, uniqueness: true
    validates :number, presence: true, numericality: { only_integer: true }, uniqueness: true, length: { minimum: 4 }
    validates :gl_type, presence: true, inclusion: { in: %w(expense income na) }
end
