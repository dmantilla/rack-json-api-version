# Rack::Json::Api::Version

Extract JSON API version number from request headers.
 
## Installation

Add this line to your application's Gemfile:

    gem 'rack-json-api-version'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-json-api-version

## Usage

In `Rails` add this to your `application.rb' file

    config.middleware.use Rack::Json::Api::Version, vendor: 'company_name'

Where `vendor` is your company name, without any dots

Request header `Accept` should be something like this: `application/vnd.my_company.v1.1+json`

In your controller you will have the version available by using

    env['api.version'] # will return 1.1

    # OR

    request.env['api.version']

This gem will modify the `Accept` headers to `application/json` and keep the original value under the `ORIGINAL_HTTP_ACCEPT` key.

If the `Accept` headers contain `application/json`, `env['api.version']` will return `nil`. In this case `ORIGINAL_HTTP_ACCEPT` won't be set.

In general, if the `Accept` header does not conform to this structure `application/vnd.my_company.vn+json` nothing will be done to the headers.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rack-json-api-version/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
