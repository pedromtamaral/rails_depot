class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    session[:counter] = 0 if session[:counter].nil?
    session[:counter] += 1
    @views = session[:counter]
  end
end
