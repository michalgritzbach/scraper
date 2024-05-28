class FetchFields < Actor
  input :parsed, type: Nokogiri::XML::Document, allow_nil: false
  input :fields, type: Hash, allow_nil: false

  output :result_set

  def call
    self.result_set = {}

    if fields.key?(:meta)
      fields.delete(:meta).each do |meta_key|
        result_set[:meta] ||= {}
        result_set[:meta][meta_key] = parsed.css("meta[name='#{meta_key}']").attr("content").text
      end
    end

    fields.each do |key, css_selector|
      result_set[key] = parsed.css(css_selector).text
    end
  end
end
