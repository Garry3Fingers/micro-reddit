class User < ApplicationRecord
  has_many :posts
  has_many :comments

  PASSWORD_FORMAT ||= /\A
    (?=.{14,30})              # Must contain 14 or up to 30 characters
    (?=.*\d)                  # Must contain a digit
    (?=.*[a-z])               # Must contain a lower case character
    (?=.*[A-Z])               # Must contain an upper case character
    (?=.*[[:^alnum:]])        # Must contain a symbol
  /x

  # Mustn't contain @ and whitespace characters in username before At sign(@).
  # Must consist of lowercase chrs, digits, a hyphen in mail sever,
  # at least two lowercase character in domain.
  EMAIL_FORMAT ||= /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :nick_name, :password, :email, :age, presence: true
  validates :nick_name, :email, uniqueness: true
  validates :age, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 18 }

  validates :password, format: {
    with: PASSWORD_FORMAT,
    message: <<-STRING.squish
              Password must contain 14 or up to 30 characters,
              a digit or more, a lower case character,
              an upper case character and a symbol.
    STRING
  }

  validates :email, format: {
    with: EMAIL_FORMAT,
    message: 'Please enter a valid email address.'
  }

  validates :first_name, :last_name, length: { maximum: 50 }
  validates :nick_name, length: { in: 3..50 }
end
