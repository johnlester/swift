require 'spec_helper'

describe "characters/new.html.haml" do
  before(:each) do
    assign(:character, stub_model(Character,
      :new_record? => true,
      :name => "MyString",
      :health => 1
    ))
  end

  it "renders new character form" do
    render

    response.should have_selector("form", :action => characters_path, :method => "post") do |form|
      form.should have_selector("input#character_name", :name => "character[name]")
      form.should have_selector("input#character_health", :name => "character[health]")
    end
  end
end
