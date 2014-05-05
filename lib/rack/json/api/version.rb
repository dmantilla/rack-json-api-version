require "rack/json/api/version/version"

module Rack
  module Json
    module Api
      class InvalidVersion < StandardError; end

      class Version
        def initialize(app, opts={})
          @app = app
          @vendor = opts[:vendor] || raise('Vendor name required')
        end

        def call(env)
          update(env)
          @app.call env
        end

        def extract_version(env)
          env['HTTP_ACCEPT'].to_s[/^application\/vnd\.#{@vendor}\.v(.+)\+json/, 1]
        end

        def update(env)
          version = extract_version(env)
          env['api.version'] = version
          unless version.nil?
            env['ORIGINAL_HTTP_ACCEPT'] = env['HTTP_ACCEPT']
            env['HTTP_ACCEPT'] = 'application/json'
          end
        end
      end
    end
  end
end
