class ParsePage < Actor
  input :body, type: String, allow_nil: false

  output :parsed

  def call
    self.parsed = Nokogiri::HTML(body)
  end
end
