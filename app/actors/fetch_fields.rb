class FetchFields < Actor
  input :parsed, type: Nokogiri::XML::Document, allow_nil: false
  input :fields, type: Hash, allow_nil: false

  output :result_set

  def call
    self.result_set = {}

    fields.each do |key, css_selector|
      result_set[key] = parsed.css(css_selector).text
    end
  end
end
