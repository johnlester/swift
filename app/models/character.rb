class Character
  include Mongoid::Document
  
  belongs_to_related :user
  
  field :name
  field :health, :type => Integer
  field :health_max, :type => Integer
  field :species
  field :career
  field :modes, :type => Array
  field :position_x, :type => Integer
  field :position_y, :type => Integer
  
end
