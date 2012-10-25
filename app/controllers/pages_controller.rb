class PagesController < ApplicationController
  def home
    @tiltle = "home"
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
end
