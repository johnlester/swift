require 'spec_helper'

describe "enemies/edit.html.haml" do
  before(:each) do
    assign(:enemy, @enemy = stub_model(Enemy,
      :new_record? => false,
      :name => "MyString",
      :health => 1,
      :health_max => 1,
      :loc_x => 1,
      :loc_y => 1
    ))
  end

  it "renders the edit enemy form" do
    render

    response.should have_selector("form", :action => enemy_path(@enemy), :method => "post") do |form|
      form.should have_selector("input#enemy_name", :name => "enemy[name]")
      form.should have_selector("input#enemy_health", :name => "enemy[health]")
      form.should have_selector("input#enemy_health_max", :name => "enemy[health_max]")
      form.should have_selector("input#enemy_loc_x", :name => "enemy[loc_x]")
      form.should have_selector("input#enemy_loc_y", :name => "enemy[loc_y]")
    end
  end
end
