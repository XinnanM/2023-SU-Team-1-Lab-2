# Basic controller for the home page
class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  # List all elements in the root page
  def index
  end
end
