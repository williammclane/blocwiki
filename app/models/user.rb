class User < ActiveRecord::Base
  has_many :wikis 
  has_many :collaborators 
  
  has_many :wiki_callaborators, through: :collaborators, source: :wiki 

  after_initialize { self.role ||= :standard }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: [:standard, :premium, :admin]
end
