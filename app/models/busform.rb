class Busform < ApplicationRecord
	has_many:stops, dependent: :nullify
end
