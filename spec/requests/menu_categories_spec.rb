require 'rails_helper'

RSpec.describe "MenuCategories", type: :request do
  let(:headers) do
    {
      'ACCEPT': 'application/json', 'Access-Token': "Aa1234"
    }
  end

  let(:sample_category) { MenuCategory.create(name: 'Test Category') }
  let(:sample_category_2) { MenuCategory.create(name: 'Test Category 2') }

  it '#index' do
    sample_category
    sample_category_2
    get '/api/v1/menu_categories', headers: headers
    body = JSON.parse(response.body)

    expect(body.count).to(eq(2))
    expect(body[0]['id']).to(eq(sample_category.id))
    expect(body[1]['id']).to(eq(sample_category_2.id))
  end

  it '#show' do
    sample_category
    get "/api/v1/menu_categories/#{sample_category.id}", headers: headers
    body = JSON.parse(response.body)

    expect(body.count).to(be)
    expect(body['id']).to(eq(sample_category.id))
  end

  it '#show undefined id' do
    sample_category
    get "/api/v1/menu_categories/3", headers: headers
    body = JSON.parse(response.body)

    expect(response.status).to(eq(422))
    expect(body['sucess']).to(be_falsey)
    expect(body['error_message']).to(be)
  end

  it '#create' do
    params = {
      name: 'Food'
    }
    post '/api/v1/menu_categories', headers: headers, params: params

    body = JSON.parse(response.body)

    expect(body.count).to(be)
    expect(response.status).to(eq(200))

  end

  it '#create fail' do
    params = {
      name: nil
    }
    post '/api/v1/menu_categories', headers: headers, params: params

    body = JSON.parse(response.body)

    expect(response.status).to(eq(422))
    expect(body['sucess']).to(be_falsey)
    expect(body['error_message']).to(be)
  end

  it '#update' do
    sample_category
    params = {
      name: 'New category name',
    }

    patch "/api/v1/menu_categories/#{sample_category.id}", headers: headers, params: params
    body = JSON.parse(response.body)

    expect(response.status).to(eq(200))
    expect(body).to(be)
    expect(body['name']).to(eq("New category name"))
  end

  it '#destroy' do
    sample_category
    delete "/api/v1/menu_categories/#{sample_category.id}", headers: headers

    expect(response.status).to(eq(200))
    expect(JSON(response.body)['success']).to(eq(true))
  end

end
