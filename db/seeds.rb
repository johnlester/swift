# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Empty the database -- very destructive!
Mongoid.master.collections.each(&:drop)

#Create a user
user = User.create!(:email => "johnlester@gmail.com", :password => "jim1dog", :name => "John")

#Create champions for user to play with
champions_to_create = [
                        {:player_character => true, :name => "Tanko", :health_max => 150, :species => "Essen", :career => :void_warrior},
                        {:player_character => true, :name => "Asiqi", :health_max => 80, :species => "Taboriin", :career => :primal},
                        {:player_character => true, :name => "Loe", :health_max => 100, :species => "Human", :career => :divine}
                        ]
champions_to_create.each do |c|
  ch = Character.create!(c)
  user.characters << ch
end

# Create a battle document and make it ready for play
enemies_to_create = [
                        {:player_character => false, :name => "Gregor", :health_max => 100, :species => "Essen", :career => :primal, :modes => ["Lich"]},
                        {:player_character => false, :name => "Okko", :health_max => 50, :species => "Human", :modes => ["Skeleton"]},
                        {:player_character => false, :name => "Pomodarodoro", :health_max => 150, :species => "Stark"}
                        ]
battle = Battle.setup_battle(user, enemies_to_create)
battle.start_battle
