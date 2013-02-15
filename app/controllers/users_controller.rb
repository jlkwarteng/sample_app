class UsersController < ApplicationController
  def new
    @title = "SIGN UP"
    @user = User.new;
  end
  
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
     render 'new'
     else
       @title = "Sign up"
       render 'new'
    end
      
    
  end
 
  
end
