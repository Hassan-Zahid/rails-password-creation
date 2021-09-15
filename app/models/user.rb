class User < ApplicationRecord
  validates :name, presence: :true
  validate :validate_password

  def validate_password
    length = false 
    length = true if password.present? && password&.length >= 10
    lower_case = false
    upper_case = false
    digit = false
    count = 1
    character = nil
    repeated_character = 0
    password&.split('')&.each do |char|
      lower_case = true if char >='a' && char <= 'z'
      upper_case = true if char >= 'A' && char <='Z'
      digit = true if char >= '0' && char <= '9'
      if character == char 
        count += 1 
      else
        count = 1
        character = char
      end
      if count == 3
        repeated_character += 1
        count = 0
      end
    end
    needed_character = 0
    if password.blank?
      needed_character = 10
    else
      contain_digit = 0
      if !lower_case || !upper_case || !digit
        contain_digit += 1 if !lower_case
        contain_digit += 1 if !upper_case
        contain_digit += 1 if !digit
      end
      needed_character += [repeated_character, contain_digit].max
      needed_character += (10 - (needed_character + password.length)) if (needed_character + password.length) < 10
    end
    errors.add(:change, "#{needed_character} characters of #{name}’s password") if needed_character > 0
  end
end
