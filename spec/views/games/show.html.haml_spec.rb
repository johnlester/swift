require 'spec_helper'

describe "games/show.html.haml" do
  before(:each) do
    assign(:game, @game = stub_model(Game)
  end

  it "renders attributes in <p>" do
    render
  end
end
