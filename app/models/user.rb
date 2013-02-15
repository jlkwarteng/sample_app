class User < ActiveRecord::Base
  require 'Digest'
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation
  
  validates(:name, :presence => true, :length => {:maximum=>50})
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates(:email, :presence => true,  
                    :format => {:with =>email_regex}, 
                    :uniqueness =>{:case_sensitive => false}
                    )
                    
  validate :password, :presence => true,
                      :length =>{ :within => 6..40},
                      :confirmation => true
  validates_confirmation_of :password,  :message => 'Correct Password'

                      
  before_save :encrypt_password
  
  
  def has_password?(submitted_password)
    self.encripted_password == encrypt(submitted_password)
    
  end
  
  def self.autheticate(email, submitted_password)
    user = User.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
    
  end
  
  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encripted_password = encrypt(password)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end