require 'spec_helper'

describe EnemiesController do

  def mock_enemy(stubs={})
    @mock_enemy ||= mock_model(Enemy, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all enemies as @enemies" do
      Enemy.stub(:all) { [mock_enemy] }
      get :index
      assigns(:enemies).should eq([mock_enemy])
    end
  end

  describe "GET show" do
    it "assigns the requested enemy as @enemy" do
      Enemy.stub(:find).with("37") { mock_enemy }
      get :show, :id => "37"
      assigns(:enemy).should be(mock_enemy)
    end
  end

  describe "GET new" do
    it "assigns a new enemy as @enemy" do
      Enemy.stub(:new) { mock_enemy }
      get :new
      assigns(:enemy).should be(mock_enemy)
    end
  end

  describe "GET edit" do
    it "assigns the requested enemy as @enemy" do
      Enemy.stub(:find).with("37") { mock_enemy }
      get :edit, :id => "37"
      assigns(:enemy).should be(mock_enemy)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created enemy as @enemy" do
        Enemy.stub(:new).with({'these' => 'params'}) { mock_enemy(:save => true) }
        post :create, :enemy => {'these' => 'params'}
        assigns(:enemy).should be(mock_enemy)
      end

      it "redirects to the created enemy" do
        Enemy.stub(:new) { mock_enemy(:save => true) }
        post :create, :enemy => {}
        response.should redirect_to(enemy_url(mock_enemy))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved enemy as @enemy" do
        Enemy.stub(:new).with({'these' => 'params'}) { mock_enemy(:save => false) }
        post :create, :enemy => {'these' => 'params'}
        assigns(:enemy).should be(mock_enemy)
      end

      it "re-renders the 'new' template" do
        Enemy.stub(:new) { mock_enemy(:save => false) }
        post :create, :enemy => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested enemy" do
        Enemy.should_receive(:find).with("37") { mock_enemy }
        mock_enemy.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :enemy => {'these' => 'params'}
      end

      it "assigns the requested enemy as @enemy" do
        Enemy.stub(:find) { mock_enemy(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:enemy).should be(mock_enemy)
      end

      it "redirects to the enemy" do
        Enemy.stub(:find) { mock_enemy(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(enemy_url(mock_enemy))
      end
    end

    describe "with invalid params" do
      it "assigns the enemy as @enemy" do
        Enemy.stub(:find) { mock_enemy(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:enemy).should be(mock_enemy)
      end

      it "re-renders the 'edit' template" do
        Enemy.stub(:find) { mock_enemy(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested enemy" do
      Enemy.should_receive(:find).with("37") { mock_enemy }
      mock_enemy.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the enemies list" do
      Enemy.stub(:find) { mock_enemy(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(enemies_url)
    end
  end

end