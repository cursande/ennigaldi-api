module Web::Controllers::Graphql
  class Execute
    include Web::Action

    def call(params)
      context = params[:context] || {}
      variables = params[:variables] || {}
      self.body = Oj.fast_generate(
        EnnigaldiSchema.execute(params[:query], context: context, variables: variables)
      )
    end
  end
end
