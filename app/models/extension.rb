require 'ruby-github'
class Extension < ActiveRecord::Base
  has_permalink :name  
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id, :counter_cache => true
  has_and_belongs_to_many :versions
  
  validates_presence_of :name, :summary, :scm_location
  
#  validates_uniqueness_of :name, :scm_location
  
  named_scope :recent, lambda { |*args| {:limit => (args.first || 3), :order => 'created_at DESC'} }  

  #before_save :check_github_scm

  def owned_by(user)
    self.author == user
  end
  
  def check_github_scm
    self.github = (/^(http|git):\/\/github.com\// === self.scm_location)
    
    if self.github
      #self.username = (/github.com\/(.*)\//.match(self.scm_location))
      #self.repository = (/radiant\/(.*)\.git/.match(self.scm_location))
      
      logger.info "EXPRESION REGULAR 1" + (/github.com\/(.*)\//.match(self.scm_location))
    end
  end
  
end