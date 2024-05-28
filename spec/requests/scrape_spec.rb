require "rails_helper"

RSpec.describe "/data" do
  let(:url) { "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm" }
  let(:fields) {
    {
      price: ".price-box__price",
      rating_count: ".ratingCount",
      rating_value: ".ratingValue"
    }
  }

  describe "POST /data" do
    context "with correct parameters and successful response" do
      it "fetches and returns specified fields in JSON response" do
        VCR.use_cassette("alza-aeg-7000") do
          post "/data", params: {url:, fields:}
        end

        expect(response).to have_http_status(:ok)
        expect(json_response[:price]).to eq("20 890,-")
        expect(json_response[:rating_count]).to eq("7 hodnocení")
        expect(json_response[:rating_value]).to eq("4,9")
      end
    end

    context "with incorrect parameters" do
      context "with incorrect URL" do
        let(:url) { "incorrect url" }

        it "returns error response" do
          post "/data", params: {url:, fields:}

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "with missing parameters" do
        let(:fields) { "invalid" }

        it "returns error response" do
          post "/data", params: {url:, fields:}

          expect(response).to have_http_status(:bad_request)
        end
      end

      context "with non-200 URL" do
        let(:url) { "https://www.alza.cz/nonexistent" }

        it "returns error response" do
          VCR.use_cassette("alza-fail") do
            post "/data", params: {url:, fields:}
          end

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
