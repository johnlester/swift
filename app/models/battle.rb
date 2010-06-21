class Battle
  include Mongoid::Document
  
  belongs_to_related :user
  has_many_related :characters
  
  field :turn_order, :type => Array
  field :active, :type => Boolean, :default => false

  #Creates battle document and the enemies for a battle to be fought in the future
  def Battle.setup_battle(user, enemies_to_create = [])
    battle = Battle.create!
    user.battles << battle
    enemies_to_create.each do |c|
      ch = Character.create!(c)
      battle.characters << ch
    end
    return battle
  end

  # Makes a battle (already existing as a document) active and ready to play
  def start_battle
    # add champions to battle
    self.user.active_characters.each do |c|
      self.characters << c
    end
    
    # establish turn order
    set_turn_order
    
    # reset health and status effects for all characters
    self.characters.each do |c|
      c.reset_health
      c.reset_status
    end
    
    #make active battle
    self.active = true
    self.save
  end
  
  #Non-player characters
  def enemies
    self.characters.where(:player_character => false)
  end
    
  def set_turn_order
    order = []
    self.characters.each do |c|
      order << c._id
    end
    self.turn_order = order.sort_by {rand}
    self.turn_order << :round_end
    self.save!
  end
  
  def characters_in_order
    result = []
    self.turn_order.each do |i|
      result << self.characters.id(i).first unless i == :round_end
    end
    return result
  end
  
  def current_character
    raise "called current_character at round end" if self.turn_order[0] == :round_end
    self.characters.id(self.turn_order[0]).first
  end

  def move_to_next_character
    self.turn_order << self.turn_order.shift
  end
  
  def opponents_of(character)
    
  end
  
  def allies_of(character)
    
  end

  # TO DO: melee engagement logic
  def melee_possible(attacker, defender)
    true
  end
  
  def current_targets(targets_type)
    result = []
    case targets_type
    when :self
      result << current_character
    when :melee_possible
      opponents_of(current_character).each do |c|
        result << c if melee_possible(current_character, c)
      end
    when :melee_active
        #TO DO
    when :all_allies
      result = allies_of(current_character)
    end
  end
  
  # TO CONSIDER: separate combat options class?
  # Compile long list of possible actions for current character
  def long_options_list
    long_list = [] # individual actions, without assigned targets
    
    APP_CONSTANTS[:combat_options].each do |option|
      can_do = true
      # Current character prereqs
      if option[:agent_prereqs]
        option[:agent_prereqs].each do |prereq, status|
          can_do = can_do && (current_character.send(prereq) == status)
        end
      end
      next unless can_do
      # Location prereqs
      if option[:location_prereqs]
        option[:ocation_prereqs].each do |prereq, status|
          can_do = can_do && (current_character.send(prereq) == status)
        end
      end

      # TO DO: other option prereqs

      long_list << deep_clone(option) if can_do
    end
    return long_list
  end

  # Assign targets to each action, and calculate damage and % chance
  def long_options_list_with_targets
      long_list = long_option_list
      long_list.each do |option|
        # process target prereqs
        # if no acceptable target, delete option from long_list
        # pick target and store in long_list
      end
      return long_list
  end

    # Combine individual actions
  end
  
  # Select short list of actions available to current character
  
end
