require 'spec_helper'

describe "enemies/index.html.haml" do
  before(:each) do
    assign(:enemies, [
      stub_model(Enemy,
        :name => "MyString",
        :health => 1,
        :health_max => 1,
        :loc_x => 1,
        :loc_y => 1
      ),
      stub_model(Enemy,
        :name => "MyString",
        :health => 1,
        :health_max => 1,
        :loc_x => 1,
        :loc_y => 1
      )
    ])
  end

  it "renders a list of enemies" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
