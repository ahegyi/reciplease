require 'spec_helper'

describe RecipesController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', @recipe
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      sign_in @user
      get 'edit', @recipe
      response.should be_success
    end

    it "redirects to index if user not signed in" do
      get 'edit'
      response.should redirect_to recipes_url
    end
  end

  pending "need to write GET new, POST create, PUT update, DELETE destroy tests"

end
