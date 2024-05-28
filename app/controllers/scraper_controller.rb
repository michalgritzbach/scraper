class ScraperController < ApplicationController
  def data
    result = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      scraped = ScrapePage.result(scrape_params.to_h.deep_symbolize_keys)
      scraped.success? ? scraped.result_set : false
    end

    if result
      render json: result
    else
      render_unprocessable_entity
    end
    # rescue # In case of invalid parameters
    #   render_bad_request
  end

  private

  def cache_key
    [scrape_params[:url], scrape_params[:fields].to_query].join("-")
  end

  def scrape_params
    params.permit(
      :url, fields: {}
    )
  end
end
