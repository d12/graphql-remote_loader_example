# GraphQL Remote Loader Example App

This is a simple Rails app showing how to use [`graphql-remote_loader`](https://github.com/d12/graphql-remote_loader). This app exposes a GraphQL API with fields backed by the GitHub GraphQL API.

![](https://i.imgur.com/H16uFGQ.png)

## Important files

There are four relevant files when it comes to understanding how `graphql-remote_loader` is used. To learn how the example app works, read the inline comments in each file,

1. http://github.com/d12/graphql-remote_loader_example/blob/master/app/graphql/types/query_type.rb
2. https://github.com/d12/graphql-remote_loader_example/blob/master/app/graphql/loaders/github_loader.rb
3. http://github.com/d12/graphql-remote_loader_example/blob/master/config/application.rb
4. http://github.com/d12/graphql-remote_loader_example/blob/master/app/graphql/graphql_remote_loader_example_schema.rb

## Running locally

First, install the gems:

```bash
bundle install
```

Done! To run the app:

```bash
TOKEN=$GITHUB_TOKEN rails server
```

## Authorization

This app is configured to use a GitHub personal access token provided as an ENV variable at runtime.

In a real world application, authorization would be more robust.
