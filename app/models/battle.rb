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
  
  # Compile long list of possible actions for current character
  def long_action_list
    basic_list = [] # individual actions, without assigned targets
    # Basic actions (simple evasion, simple attacks)
    # => Slap
    # => Kick
    # => Cringe
    # => Run around screaming
    # => Stay wary
    
    # Object-based actions
    # => Drink potions
    
    # Career-based actions
    case current_character.career
    when 'Void Warrior'

      basic_list << { :description => "Call out a piercing ululation, emboldening your allies' melee attacks",
                      :frequency => 100,
                      :value => 50,
                      :effects => [
                                  {:targets => :all_allies, :delivery => :sound, :odds => :always, :effect => :improve_melee_odds, :magnitude => 30}
                                  ]
                    }

      basic_list << { :description => "Rush TARGET, causing DAMAGE damage and distracting TARGET_PRONOUN from spellcasting next turn",
                      :frequency => 100,
                      :value => 50,
                      :effects => [
                                  {:targets => :melee_possible, :delivery => :melee, :odds => 80, :effect => :main_weapon, :magnitude => 30},
                                  {:targets => :prior, :delivery => :melee, :contigent => true, :odds => :always, :effect => :no_spellcasting, :duration => 1}
                                  ]
                    }

      basic_list << { :description => "Embue TARGET with the Void, reducing all damage TARGET_PRONOUN takes by 50% for the next 3 rounds",
                      :frequency => 200,
                      :value => 100,
                      :effects => [
                                  {:targets => :self, :delivery => :always, :odds => always, :effect => :reduce_all_damage, :duration => 3}
                                  ]
                    }

      if current_character.using_shield?
        basic_list << { :description => "Ram TARGET with SHIELD, causing DAMAGE damage, and perhaps also knocking TARGET_PRONOUN down",
                        :frequency => 100,
                        :value => 100,
                        :effects => [ 
                                    {:targets => :melee_possible, :delivery => :melee, :odds => 120, :effect => :blunt_force, :magnitude => 100},
                                    {:targets => :prior, :delivery => :melee, :contingent => true, :odds => 20, :effect => :knockdown}
                                    ]
                      }
      end
      
      
    end
    # Weapon-based actions
    
    # Mode-based actions
    
    # Species-based actions

    # Opponent individual-history-based actions (e.g. planar summons who desire vengeance against the enemy)

    # Self individual-history-based actions (e.g. gods who owe a favor)

    # Assign targets to each action, and calculate damage and % chance

    # Combine individual actions
  end
  
  # Select short list of actions available to current character
  
end
