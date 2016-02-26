require 'spec_helper'

describe Api::V1::UsersController do
  before(:each) do
    request.headers['Accept'] = "application/vnd.maketplace.v1, #{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  end
  
  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_atttributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_atttributes }, format: :json
      end
      it "renders the json representation for the user record just created" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql @user_atttributes[:email]
      end
      it {should respond_with 201}
    end

    context "when is not created" do
      before(:each) do
        @invalid_user_attributes = { password: "123456789", password_confirmation: "123456789"}
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders a error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "render the json error on why the user could not created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it {should respond_with 422}
    end
  end
  
  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers['Authorization'] = @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, {id: @user.id, user: {email: "nhamtybv@gmail.com"}}, format: :json
      end

      it "render the json representation for the updated user" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql "nhamtybv@gmail.com"
      end

      it {should respond_with 200}
    end

    context "when is not updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id, user: {email: "halinh.com"} }, format: :json
      end

      it "render an error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "render the json errors on why the user could not be updated" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it {should respond_with 422}
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      delete :destroy, {id: @user.id}, format: :json
    end

    it { should respond_with 204 }
  end


  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      puts json_response
      user_response = json_response[:user] 
      #user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end

    it {should respond_with 200}
  end
end
