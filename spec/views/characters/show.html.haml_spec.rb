require 'spec_helper'

describe "characters/show.html.haml" do
  before(:each) do
    assign(:character, @character = stub_model(Character,
      :name => "MyString",
      :health => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain(1)
  end
end
