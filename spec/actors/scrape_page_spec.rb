require "rails_helper"

RSpec.describe ScrapePage do
  describe ".result" do
    subject(:scrape_page) { described_class.result(url:, fields:) }

    let(:fields) {
      {
        price: ".price-box__price"
      }
    }

    context "when successful" do
      let(:url) { "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm" }

      it "returns fields from the parsed document" do
        VCR.use_cassette("alza-aeg-7000") do
          expect(scrape_page).to be_success
          expect(scrape_page.result_set[:price]).to eq("20 890,-")
        end
      end
    end

    context "when not successful" do
      let(:url) { "https://www.alza.cz/nonexistent" }

      it "fails" do
        VCR.use_cassette("alza-fail") do
          expect(scrape_page).to be_failure
        end
      end
    end
  end
end
