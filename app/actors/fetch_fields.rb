class FetchFields < Actor
  fail_on Nokogiri::SyntaxError

  input :parsed, type: Nokogiri::XML::Document, allow_nil: false
  input :fields, type: Hash, allow_nil: false

  output :result_set

  def call
    self.result_set = {}

    result_set[:meta] = collect_meta_tags(fields.delete(:meta)) if fields.key?(:meta)

    fields.each do |key, css_selector|
      result_set[key] = parsed.css(css_selector).text
    end
  end

  private

  def collect_meta_tags(meta_keys)
    meta_tags = {}

    meta_keys.each do |meta_key|
      meta_tags[meta_key] = parsed.css("meta[name='#{meta_key}']").attr("content")&.text
    end

    meta_tags
  end
end
