require 'spec_helper'

describe "games/edit.html.haml" do
  before(:each) do
    assign(:game, @game = stub_model(Game,
      :new_record? => false
    ))
  end

  it "renders the edit game form" do
    render

    response.should have_selector("form", :action => game_path(@game), :method => "post") do |form|
    end
  end
end
