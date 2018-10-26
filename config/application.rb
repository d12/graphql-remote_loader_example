require_relative 'boot'

require 'rails/all'

require "graphql/client/http"

Bundler.require(*Rails.groups)

module GraphqlRemoteLoaderExample
  class Application < Rails::Application
    config.load_defaults 5.2
  end

  # Defining the GraphQL::Client HTTP adapter and client that we use in app/graphql/loader/github_loader.rb
  # This can be swapped out with any other way of querying a remote GraphQL API.
  GitHubHTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      {
        "Authorization" => "Bearer #{ENV["TOKEN"]}"
      }
    end
  end

  ::GitHubClient = GraphQL::Client.new(
    schema: Application.root.join("db/graphql_schema.json").to_s,
    execute: GraphqlRemoteLoaderExample::GitHubHTTPAdapter
  )

  GitHubClient.allow_dynamic_queries = true
end
