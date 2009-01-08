module Waves
  module Layers
    module MVC

      def self.included( app )
        
        require 'layers/mvc/extensions'
        require 'layers/mvc/controllers'
        
        app.auto_create_module( :Models ) do
          include AutoCode
          auto_create_class :Default
          auto_load :Default, :directories => [ :models ]
          auto_create_class true, :Default
          auto_load true, :directories => [ :models ]
        end

        app.auto_create_module( :Views ) do
          include AutoCode
          auto_create_class :Default, Waves::Views::Base
          auto_load :Default, :directories => [ :views ]
        end
        
        app.auto_eval( :Views ) do
          auto_create_class true, :Default
          auto_load true, :directories => [ :views ]
        end

        app.auto_create_module( :Controllers ) do
          include AutoCode
          auto_create_class :Default, Waves::Controllers::Base
          auto_load :Default, :directories => [ :controllers ]
          auto_create_class true, :Default
          auto_load true, :directories => [ :controllers ]          
        end

        app.auto_create_module( :Helpers ) do
          include AutoCode
          auto_create_module( :Default ) { include Waves::Helpers::Extended }
          auto_load :Default, :directories => [ :helpers ]
        end
        
        app.auto_eval( :Helpers ) do
          auto_create_module( true ) { include app::Helpers::Default }
          auto_load true, :directories => [ :helpers ]
        end
        
      end
    end
  end
end
