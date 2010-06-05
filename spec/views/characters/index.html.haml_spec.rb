require 'spec_helper'

describe "characters/index.html.haml" do
  before(:each) do
    assign(:characters, [
      stub_model(Character,
        :name => "MyString",
        :health => 1
      ),
      stub_model(Character,
        :name => "MyString",
        :health => 1
      )
    ])
  end

  it "renders a list of characters" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
