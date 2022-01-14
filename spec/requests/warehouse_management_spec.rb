require 'rails_helper'

describe 'Warehouse Requests', type: :request do
  it 'should refuse warehouse creation if unauthenticated' do
    
    post '/warehouses'

    expect(response.status).to eq 302
    expect(response.redirect_url).to eq new_user_session_url
    expect(response).to redirect_to(new_user_session_url)
  end

  it 'should refuse warehouse creation if unauthenticated - v2' do
    
    post '/warehouses'
    follow_redirect!

    expect(response.body).to include 'Entrar'
  end
end