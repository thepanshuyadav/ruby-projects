require 'rails_helper'

RSpec.describe 'Api::V1::Articles', type: :request do
  # let(:some_user) { FactoryBot.create(:user, name: 'user1') }
  # describe 'GET /api/v1/articles' do
  #   # runs the block one time before each of specs in the file
  #   before(:each) do
  #     FactoryBot.create(:article, title: 'Some title', description: 'Some description', likes_count: 0, user: some_user)
  #   end

  #   it 'returns all articles' do
  #     get '/api/v1/articles'
  #     expect(response).to have_http_status(:success)
  #     expect(JSON.parse(response.body).size).to eq(1)
  #     expect(JSON.parse(response.body)).to eq(
  #       [{
  #         'description' => 'Some description',
  #         'likes_count' => 0,
  #         'title' => 'Some title',
  #         'user_id' => some_user.id
  #       }]
  #     )
  #   end
  # end

  # describe 'POST /api/v1/articles' do
  #   # runs the block one time before each of specs in the file
  #   before(:each) do
  #     FactoryBot.create(:article, title: 'Some title', description: 'Some description', likes_count: 0, user: some_user)
  #   end

  #   it 'creates new article' do
  #     post '/api/v1/articles', params: {
  #       article: {
  #         user: some_user.id,
  #         title: 'Some title',
  #         description: 'Some description'
  #       }
  #     }
  #     expect(response).to have_http_status(:success)
  #     expect(JSON.parse(response.body).size).to eq(
  #       [{
  #         'description' => 'Some description',
  #         'title' => 'Some title',
  #         'likes_count' => 0,
  #         'user_id' => some_user.id
  #       }]
  #     )
  #   end
  # end
end
