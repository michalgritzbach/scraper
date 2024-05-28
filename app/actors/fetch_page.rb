class FetchPage < Actor
  fail_on StandardError

  input :url, type: String, allow_nil: false

  output :body

  def call
    # Cache the body of a successful response. nil/failure won't be cached.
    self.body = Rails.cache.fetch(url, expires_in: 1.hour) do
      response = HTTParty.get(URI(url))

      fail!(error: response.code.to_s) unless response.success?

      response.body
    end
  end
end
