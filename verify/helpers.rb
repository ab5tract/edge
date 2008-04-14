$:.unshift( 'lib' )
require 'lib/waves.rb'
module Test ; include Waves::Foundations::Simple ; end
Waves << Test

module Helpers

  def path(*args)
    ::Test::Configurations::Mapping.path(*args)
  end
  
  def mock_request
    @mock = Rack::MockRequest.new( Waves::Dispatchers::Default.new )
  end
  
  [:get,:put,:post,:delete].each do |method|
    define_method method do | path |
      @mock.send( method, path )
    end
  end
  
end

module Kernel
  private
  def specification(name, &block)  Bacon::Context.new(name, &block) end
end

Bacon::Context.instance_eval do
  include Helpers 
  alias_method :specify, :it
end