class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation
  validates(:name, :presence => true, :length => {:maximum=>50})
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, :presence => true,  
                    :format => {:with =>email_regex}, 
                    :uniqueness =>{:case_sensitive => false}
                    )
  validate(:password, :presence => true,
                      :confirmation => true,
                      :length =>{ :within => 6..40}
                      )
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    #compate the submitted_pasword with the one in the database
    
  end
  
  private
  def encrypt_password
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt(string)
    string 
    
  end
end
