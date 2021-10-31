require 'rails_helper'

RSpec.describe "MenuItems", type: :request do
  let(:headers) do
    {
      'ACCEPT': 'application/json', 'Access-Token': "Aa1234"
    }
  end

  let(:sample_menu_item) { MenuItem.create(name: 'Test', price: 10) }
  let(:sample_menu_item2) { MenuItem.create(name: 'Test 2', price: 50) }

  it '#index' do
    sample_menu_item
    sample_menu_item2

    get '/menu_items', headers: headers
    body = JSON.parse(response.body)
    # puts body

    expect(body.count).to(eq(2))
    expect(body[0]['id']).to(eq(sample_menu_item.id))
    expect(body[1]['id']).to(eq(sample_menu_item2.id))

  end

  it '#show' do
    sample_menu_item

    get "/menu_items/#{sample_menu_item.id}", headers: headers
    body = JSON.parse(response.body)

    expect(body.count).to(be)
    expect(body['id']).to(eq(sample_menu_item.id))

  end

  it '#show-fail-undefined-id' do
    sample_menu_item

    get "/menu_items/2", headers: headers
    body = JSON.parse(response.body)

    expect(body['success']).to(eq(false))

  end

  it '#create' do
    params = {
      name: 'Test 3',
      price: 80
    }
    post '/menu_items', headers: headers, params: params
    body = JSON.parse(response.body)
    puts body

    expect(body.count).to(be)
    expect(response.status).to(eq(200))
  end

  it '#create-fail-name' do
    params = {
      name: nil,
      price: 1
    }
    post '/menu_items', headers: headers, params: params
    body = JSON.parse(response.body)
    expect(response.status).to(eq(422))
    expect(body['sucess']).to(be_falsey)
    expect(body['error_message']).to(be)
  end

  it '#create-fail-price' do
    params = {
      name: 'Test 1',
      price: nil
    }
    post '/menu_items', headers: headers, params: params
    body = JSON.parse(response.body)
    expect(response.status).to(eq(422))
    expect(body['sucess']).to(be_falsey)
    expect(body['error_message']).to(be)
  end

  it '#update' do
    sample_menu_item
    params = {
      name: 'New product name',
      price: 90
    }

    patch "/menu_items/#{sample_menu_item.id}", headers: headers, params: params
    body = JSON.parse(response.body)

    expect(response.status).to(eq(200))
    expect(body).to(be)
    expect(body['name']).to(eq("New product name"))

  end

  it '#destroy' do
    sample_menu_item

    delete "/menu_items/#{sample_menu_item.id}", headers: headers
    expect(response.status).to(eq(200))
    expect(JSON(response.body)['success']).to(eq(true))
  end

  it '#destroy-fail' do
    sample_menu_item

    delete "/menu_items/2", headers: headers
    expect(response.status).to(eq(422))
    expect(JSON(response.body)['success']).to(eq(false))
  end
end
