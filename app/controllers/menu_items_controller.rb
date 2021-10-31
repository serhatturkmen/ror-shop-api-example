class MenuItemsController < ApplicationController
  before_action :find_menu_item, only: %i[show update destroy]

  def index
    @menu_items = MenuItem.all
  end

  def show; end

  def create
    @menu_item = MenuItem.create!(create_params)
  end

  def update
    @menu_item.update!(create_params)
  end

  def destroy
    @menu_item.destroy!
    render json: { success: true, error_message: nil }
  end

  private

  def find_menu_item
    @menu_item = MenuItem.find(show_params[:id])
  end

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:name, :price)
  end

end
