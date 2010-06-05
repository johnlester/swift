# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


Mongoid.master.collections.each(&:drop)
user = User.create!(:email => "johnlester@gmail.com", :password => "jim1dog", :name => "John")
user.characters << Character.create!(:name => "Tanko", :health_max => 150, :species => "Essen", :career => "Void Warrior")
user.characters << Character.create!(:name => "Asiqi", :health_max => 80, :species => "Taboriin", :career => "Primal")
user.characters << Character.create!(:name => "Loe", :health_max => 100, :species => "Human", :career => "Divine")

user.enemies << Enemy.create!(:name => "Gregor", :health_max => 100, :species => "Essen", :career => "Planetouched", :modes => ["Lich"])
user.enemies << Enemy.create!(:name => "Okko", :health_max => 50, :species => "Human", :modes => ["Skeleton"])
user.enemies << Enemy.create!(:name => "Pomodarodoro", :health_max => 150, :species => "Stark")

