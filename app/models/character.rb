class Character
  include Mongoid::Document
  
  belongs_to_related :user
  belongs_to_related :battle
    
  field :name
  field :health, :type => Integer
  field :health_max, :type => Integer
  field :species
  field :career
  field :modes, :type => Array
  field :position_x, :type => Integer
  field :position_y, :type => Integer
  field :player_character, :type => Boolean
  
  # validates_presence_of :player_character
  
  def reset_health
    self.health = self.health_max
    self.save!
  end
  
  def reset_status
    
  end
  
  def using_shield?
    
  end
  
  def last_enemy_meleed
    
  end
  
  # TO DO: implement fear logic
  def scared
    false
  end
  
  # def enemies_killed
  
  #What do I need to know about this character in a battle?
  # Last enemy that character melee attacked
  # Enemies who last melee attacked this character 
  
end
