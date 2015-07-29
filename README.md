# retriable_proxy

[![Build Status](https://travis-ci.org/julik/retriable_proxy.svg?branch=master)](https://travis-ci.org/julik/retriable_proxy)

Creates an object wrapper on top of [Retriable.](https://github.com/kamui/retriable)
The accepted keyword arguments are the same as for Retriable itself.

    network_interface = API.new(unreliable_server: 'https://api-server.com')
    stubborn_interface = RetriableProxy.for_object(network_interface, on: Net::TimeoutError)
    stubborn_interface.create(id: 123, name: 'Some object that gets created') # Will retry

If you only want to wrap certain methods, add the `:methods` option and pass in an `Array` of symbols.

    network_interface = API.new(unreliable_server: 'https://api-server.com')
    stubborn_interface = RetriableProxy.for_object(network_interface, on: Net::TimeoutError, methods: [:fetch_comments])
    stubborn_interface.create(id: 123, name: 'Some object that gets created') # Will not retry
    stubborn_interface.fetch_comments # Will do retry

## Contributing to retriable_proxy
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2015 Julik Tarkhanov. See LICENSE.txt for
further details.

