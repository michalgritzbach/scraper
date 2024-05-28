class ScrapePage < Actor
  play FetchPage,
    ParsePage,
    FetchFields

  input :url, type: String, allow_nil: false
  input :fields, type: Hash, allow_nil: false
end
