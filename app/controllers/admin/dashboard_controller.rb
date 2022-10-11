class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_PAGE_USERNAME'], password: ENV['ADMIN_PAGE_PASSWORD']
  def show
    @inventory_count = Product.sum(:quantity)
    @category_count = Product.count(:category_id)
  end
end
