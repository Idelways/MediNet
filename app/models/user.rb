class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :headline, :picture_url
  
  def fullname
    "#{firstname} #{lastname}"
  end
  
  def slug
    fullname.parameterize
  end
  
  def update_from_linkedin(client_ready)    
    profile = client_ready.profile(:fields => ["first_name", "last_name", "headline", "picture-url"])
    
    client_ready.profile.tap do |profil| 
      self.firstname = profil.first_name
      self.lastname = profil.last_name
      self.headline = profil.headline 
      self.picture_url = profil.picture_url
    end
    
    save
  end
end
