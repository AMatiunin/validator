require_relative 'validate'

class UserValidator
  include Validate

  validates :name, type: String
  validates :age, type: Integer
  validates :age,
            msg: 'must be positive',
            with: proc { |p| p.age > 0 }
end

class User
  include Validation

  attr_accessor :name, :age
end
