require 'retriable'
require_relative 'retriable_proxy/version'

module RetriableProxy
  
  class Wrapper
    # Creates a new Wrapper that will wrap the messages to the wrapped object with
    # a +retriable+ block.
    #
    # If the :methods option is passed, only the methods in the given array will be
    # subjected to retries.
    def initialize(with_object, options_for_retriable = {})
      @o = with_object
      @methods = options_for_retriable.delete(:methods)
      @retriable_options = options_for_retriable
    end
  
    # Returns the wrapped object
    def __getobj__
      @o
    end
  
    # Assists in supporting method_missing
    def respond_to_missing?(*a)
      @o.respond_to?(*a)
    end
  
    # Forwards all methods not defined on the Wrapper to the wrapped object.
    def method_missing(method_name, ...)
      __retrying(method_name) { @o.public_send(method_name, ...) }
    end
  
    private
  
    # Executes a block within Retriable setup with @retriable_options
    def __retrying(method_name_on_delegate)
      if @methods.nil? || @methods.include?(method_name_on_delegate)
        Retriable.retriable(@retriable_options) { yield }
      else
        yield
      end
    end
  end
  
  
  def self.for_object(object, retriable_opts={})
    Wrapper.new(object, retriable_opts)
  end
end
