module Waves
  
  module Resources
    
    module Mixin
      
    end
    
  end
  
  module ResponseMixin

    # Returns the name of the model corresponding to this controller by taking the basename
    # of the module and converting it to snake case. If the model plurality is different than
    # the controller, this will not, in fact, be the model name.
    def model_name; self.class.basename.snake_case; end

    # Returns the model corresponding to this controller by naively assuming that 
    # +model_name+ must be correct. This allows you to write generic controller methods such as:
    #
    #   model.find( name )
    #
    # to find an instance of a given model. Again, the plurality of the controller and
    # model must be the same for this to work.
    def model( resource = nil )
      resource ||= self.class.basename.snake_case
      app::Models[ resource ]
    end

    def controller( resource = nil )
      resource ||= self.class.basename.snake_case
      @controller ||= app::Controllers[ resource ].new( @request )
    end
    
    def view( resource = nil )
      resource ||= self.class.basename.snake_case
      @view ||= app::Views[ resource ].new( @request )
    end

    # MVC Params get automatically destructured with the keys as accessors methods.
    # You can still access the original query by calling request.query
    def query
      @query ||= Waves::Request::Query.new( 
        Waves::Request::Utilities.destructure( request.query ) )
    end
    
    # Both the query and capture merged together
    def params 
      @params ||= Waves::Request::Query.new( captured ? 
         Waves::Request::Utilities.destructure( request.query ).merge( captured.to_h ) : 
          Waves::Request::Utilities.destructure( request.query ) ) 
    end

    # Attributes are just the query elements specific to the model associated with
    # the current resource.
    def attributes
      query[ model_name ]
    end

  end

end