require 'spec_helper'

describe Api::V1::ProductsController do
  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end

    it "returns the information about a reporter on hash" do
      product_response = json_response
      expect(product_response[:title]).to eql @product.title
    end

    it {should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      5.times { FactoryGirl.create :product}
      get :index
    end

    it "returns 5 records from the database" do
      product_response = json_response
      expect(product_response[:products]).to have(5).items
    end

    it {should respond_with 200}
  end
end
