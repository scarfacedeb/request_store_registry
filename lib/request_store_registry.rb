require "request_store_registry/version"
require "request_store"

# This modules provides API for RequestStore, that is similar to ActiveSupport::PerThreadRegistry API
#
# Instead of polluting the thread locals namespace:
#
#   Thread.current[:connection_handler]
#
# you can define a class that extends ActiveSupport::PerThreadRegistry module.
#
# But if you're using threaded web servers, like Thin or Puma, old values can stick around longer that you'd expect.
#
# The solution to this problem is request_store gem by Steve Klabnik, that makes the global storage local to the request.
#
# You define a class that extends this module:
#
#   module ActiveRecord
#     class RuntimeRegistry
#
#       extend RequestStoreRegistry
#
#       attr_accessor :connection_handler
#     end
#   end
#
# and invoke the declared instance accessors as class methods. So
#
#   ActiveRecord::RuntimeRegistry.connection_handler = connection_handler
#
# sets a connection handler local to the current thread, and
#
#   ActiveRecord::RuntimeRegistry.connection_handler
#
# returns a connection handler local to the current thread.
#
# If the class has an initializer, it must accept no arguments.
module RequestStoreRegistry
  def self.extended(object)
    object.instance_variable_set '@request_store_registry_key', object.name.freeze
  end

  def instance
    RequestStore.store[@request_store_registry_key] ||= new
  end

  protected

  def method_missing(name, *args, &block) # :nodoc:
    # Caches the method definition as a singleton method of the receiver.
    define_singleton_method(name) do |*a, &b|
      instance.public_send(name, *a, &b)
    end

    send(name, *args, &block)
  end
end
