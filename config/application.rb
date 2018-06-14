require_relative 'boot'

require 'rails/all'

require "graphql/client/http"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GraphqlRemoteLoaderExample
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end

  HTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      {
        "Authorization" => "Bearer #{ENV["TOKEN"]}"
      }
    end
  end

  ::GitHubClient = GraphQL::Client.new(
    schema: Application.root.join("db/graphql_schema.json").to_s,
    execute: GraphqlRemoteLoaderExample::HTTPAdapter
  )

  GitHubClient.allow_dynamic_queries = true
end
