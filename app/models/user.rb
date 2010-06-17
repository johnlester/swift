class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many_related :battles
  has_many_related :characters
    
  field :name

  def active_battle
    self.battles.where(:active => true).first
  end

  def active_characters
    self.characters   #would need to expand eventually
  end

end
