class PlayController < ApplicationController
  
  before_filter :authenticate_user!

  # GET /play
  def index
    @battle = current_user.active_battle
    @characters = @battle.characters_in_order

    respond_to do |format|
      format.html # index.html.haml
    end
  end

end
