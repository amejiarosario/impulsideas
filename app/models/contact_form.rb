class ContactForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming


  attr_accessor :name
  attr_accessor :email
  attr_accessor :message

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

 def persisted?
    false
  end

  validates :name, presence: true
  validates :email, :format => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates :message, presence: true
end
