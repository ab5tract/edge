module Waves

  module Matchers

    class Base
      
      attr_accessor :constraints
      
      def []( *args ) ; call( *args ) ; end
      
      # used to provide consisting matching logic across all matchers
      def test( request )
        constraints.all? do | key, val |
          return true if val.nil?
          if val.respond_to? :call
            val.call( request )
          else
            val == request.send( key ) or val === request.send( key )
          end
        end
      end
      
    end
    
  end
  
end