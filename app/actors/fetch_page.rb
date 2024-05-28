class FetchPage < Actor
  input :url, type: String, allow_nil: false

  output :body

  def call
    response = HTTParty.get(URI(url))
    fail!(error: response.code.to_s) unless response.success?

    self.body = response.body
  rescue => error
    fail!(error: error.message)
  end
end
