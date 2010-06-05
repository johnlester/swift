require 'spec_helper'

describe "characters/edit.html.haml" do
  before(:each) do
    assign(:character, @character = stub_model(Character,
      :new_record? => false,
      :name => "MyString",
      :health => 1
    ))
  end

  it "renders the edit character form" do
    render

    response.should have_selector("form", :action => character_path(@character), :method => "post") do |form|
      form.should have_selector("input#character_name", :name => "character[name]")
      form.should have_selector("input#character_health", :name => "character[health]")
    end
  end
end
