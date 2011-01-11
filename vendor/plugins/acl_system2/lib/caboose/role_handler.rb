module Caboose
  
  class AccessHandler   
    include LogicParser

    def check(key, context)
      false
    end
  
  end
   
  class RoleHandler < AccessHandler 
    
    def check(key, context)  
      context[:user].roles.map{ |role| role.titulo.downcase}.include? key.downcase
    end
        
  end # End RoleHandler

end
