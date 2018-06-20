require_relative "../loaders/github_loader"

class Types::QueryType < Types::BaseObject
  field :login, String, null: false, description: "The currently authenticated GitHub user's login."

  def login
    GitHubLoader.load("viewer { login }").then do |results|
      results["data"]["viewer"]["login"]
    end
  end

  field :is_famous, Boolean, null: false, description: "Is the user famous?"

  def is_famous
    query = <<~GRAPHQL
      viewer{
        followers{
          totalCount
        }
        repositories(first: 1, orderBy: { field: STARGAZERS, direction: DESC }){
          nodes{
            stargazers{
              totalCount
            }
          }
        }
      }
    GRAPHQL

    GitHubLoader.load(query).then do |results|
      # We define "famous" as either >5000 followers,
      # or a repo with >5000 stars
      follower_count = results["data"]["viewer"]["followers"]["total_count"].to_i
      star_count = results["data"]["viewer"]["repositories"]["nodes"][0]["stargazers"]["total_count"].to_i

      (follower_count > 5000) || (star_count > 5000)
    end
  end

  field :repository_count, Integer, null: false, description: "The total number of owner repositories that the user has."

  def repository_count
    GitHubLoader.load("viewer { repositories(affiliations: OWNER) { totalCount } }").then do |results|
      results["data"]["viewer"]["repositories"]["total_count"]
    end
  end

  field :issue_count, Integer, null: false, description: "The total number of issues the user has authored."

  def issue_count
    GitHubLoader.load("viewer { issues { totalCount } }").then do |results|
      results["data"]["viewer"]["issues"]["total_count"]
    end
  end

  field :pull_request_count, Integer, null: false, description: "The total number of pull requests the user has authored."

  def pull_request_count
    GitHubLoader.load("viewer { pullRequests { totalCount } }").then do |results|
      results["data"]["viewer"]["pull_requests"]["total_count"]
    end
  end
end
