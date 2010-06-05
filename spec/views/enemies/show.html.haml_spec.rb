require 'spec_helper'

describe "enemies/show.html.haml" do
  before(:each) do
    assign(:enemy, @enemy = stub_model(Enemy,
      :name => "MyString",
      :health => 1,
      :health_max => 1,
      :loc_x => 1,
      :loc_y => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain(1)
    response.should contain(1)
    response.should contain(1)
    response.should contain(1)
  end
end
