# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/articles', to: 'articles#fetch'
get '/graphql/execute', to: 'graphql#execute'
