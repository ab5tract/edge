module Waves
  module Layers
    module ORM
      
      module Filebase
        
        def self.included(app)
          app.module_eval
            autoinit( :Models ) do
          	  include Autocode
          	  autoinit true { include Filebase::Model[ :db / self.name.snake_case ] }
          	end
          end
        end
        
      end
    
    end
    
  end
  
end
