require 'spec_helper'

describe "games/new.html.haml" do
  before(:each) do
    assign(:game, stub_model(Game,
      :new_record? => true
    ))
  end

  it "renders new game form" do
    render

    response.should have_selector("form", :action => games_path, :method => "post") do |form|
    end
  end
end
