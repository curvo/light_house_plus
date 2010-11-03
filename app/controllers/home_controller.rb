class HomeController < ApplicationController
  def redirect
    redirect_to search_path
  end
end