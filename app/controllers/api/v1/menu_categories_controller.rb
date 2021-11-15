class Api::V1::MenuCategoriesController < ApplicationController
  before_action :find_menu_category, only: %i[show update destroy]

  def index
    @menu_categories = MenuCategory.all
  end
  def show; end

  def create
    @menu_category = MenuCategory.create!(menu_category_params)
  end

  def update
    @menu_category.update!(menu_category_params)
  end

  def destroy
    @menu_category.destroy!
    render json: { success: true, error_message: nil }
  end

  private

  def find_menu_category
    @menu_category = MenuCategory.find(show_params[:id])
  end

  def show_params
    params.permit(:id)
  end

  def menu_category_params
    params.permit(:name)
  end
end
