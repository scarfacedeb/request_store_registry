# RequestStoreRegistry

If you need a global state for a request in Rails, [request_store](https://github.com/steveklabnik/request_store) by Steve Klabnik is a great solution.

This gem provides API for `RequestStore`, that is similar to [ActiveSupport::PerThreadRegistry](http://api.rubyonrails.org/classes/ActiveSupport/PerThreadRegistry.html) API.

## Usage

You define a class that extends this module:
```ruby
  module ActiveRecord
    class RuntimeRegistry
      extend RequestStoreRegistry
      attr_accessor :connection_handler
    end
  end
```

and invoke the declared instance accessors as class methods. So
``` ruby
  ActiveRecord::RuntimeRegistry.connection_handler = connection_handler
```

sets a connection handler local to the current thread, and

```ruby
  ActiveRecord::RuntimeRegistry.connection_handler
```

returns a connection handler local to the current thread.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/request_store_registry/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
