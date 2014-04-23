require 'spec_helper'

describe Api::EdgesController do
  describe "GET index" do
    it 'responds with 200 status' do
      get 'index'
      expect(response.status).to eq(200)
    end

    it 'responds with json' do
      category = Category.create(name: 'category')
      requirement = Requirement.create(name: 'req', value: 'val', mode: 'rank')
      edge = Edge.create({ name: 'name', description: 'desc', category: category, requirements: [ requirement] })
      get 'index'
      parsed = JSON.parse(response.body)
      expect(parsed[0]["category"]["name"]).to eq('category')
    end
  end
end