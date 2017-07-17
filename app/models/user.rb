class User < ApplicationRecord
	has_many :rooms, :dependent => :destroy
	has_many :reviews, :dependent => :destroy
	validates_presence_of :email, :full_name, :location, :password, on: :create
	validates_confirmation_of :password, on: :create

	validates_length_of :bio, :minimum => 30, :allow_blank => false
	validates_uniqueness_of :email
	validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	has_secure_password

	before_create :generate_token
	#attr_accessor :confirmation_token, :confirmed_at
	def generate_token
		self.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?
		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end

	scope :confirmed, ->{
		where('confirmed_at IS NOT NULL')
	}

	#o metdodo :authenticate já criptografa :password e teste com o equivalente no banco de dados
	def self.authenticate(email, password)
		confirmed.find_by_email(email).try(:authenticate, password)
	end
end
