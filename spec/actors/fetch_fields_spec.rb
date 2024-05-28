require "rails_helper"

RSpec.describe FetchFields do
  describe ".result" do
    subject(:fetch_fields) { described_class.result(parsed: parsed_page.parsed, fields:) }

    let(:parsed_page) { ParsePage.result(body:) }
    let(:fields) {
      {
        price: ".price-box__price",
        rating_count: ".ratingCount",
        rating_value: ".ratingValue"
      }
    }

    context "with successfuly parsed page" do
      let(:body) do
        VCR.use_cassette("alza-aeg-7000") do
          HTTParty.get("https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm")
        end.body
      end

      it "fetches values by provided css selectors" do
        expect(fetch_fields).to be_success
        expect(fetch_fields.result_set[:price]).to eq("20 890,-")
        expect(fetch_fields.result_set[:rating_count]).to eq("7 hodnocení")
        expect(fetch_fields.result_set[:rating_value]).to eq("4,9")
      end

      context "with nonexistent selector" do
        let(:fields) {
          {
            something: ".nonexistent-selector"
          }
        }

        it "passes with empty values" do
          expect(fetch_fields).to be_success
          expect(fetch_fields.result_set[:something]).to be_blank
        end
      end
    end
  end
end
