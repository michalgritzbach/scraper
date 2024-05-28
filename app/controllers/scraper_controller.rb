class ScraperController < ApplicationController
  def data
    scraped = ScrapePage.result(scrape_params.to_h.deep_symbolize_keys)

    if scraped.success?
      render json: scraped.result_set
    else
      render_unprocessable_entity
    end
  rescue # In case of invalid parameters
    render_bad_request
  end

  private

  def scrape_params
    params.permit(
      :url, fields: {}
    )
  end
end
