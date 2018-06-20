require "graphql/remote_loader"

class GitHubLoader < GraphQL::RemoteLoader::Loader
  def query(query_string)
    parsed_query = GitHubClient.parse(query_string)
    GitHubClient.query(parsed_query, variables: {}, context: {})
  end
end
