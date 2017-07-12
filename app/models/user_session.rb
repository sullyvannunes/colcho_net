class UserSession
  include ActiveModel::Validations
  include ActiveModel::Conversion

  extend ActiveModel::Naming
  extend ActiveModel::Translation

  attr_accessor :email, :password

  validates_presence_of :email, :password

  def initialize(session, attributes={})
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end

  def authenticate
    user = User.authenticate(@email, @password)
    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end

  #implementação obrigatoria de include ActiveModel::Conversion
  def persisted?
    false
  end

  #Guarda o id do usuario na sessão
  def store(user)
    @session[:user_id] = user.id
  end

  #Retorna o objeto da classe User que esta logado no momento
  def current_user
    User.find(@session[:user_id])
  end

  #Retorna true se o usuário estiver logado
  def user_signed_in?
    @session[:user_id].present?
  end
end
