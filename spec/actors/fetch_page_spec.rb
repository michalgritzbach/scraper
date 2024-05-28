require "rails_helper"

RSpec.describe FetchPage do
  describe ".result" do
    subject(:fetch_page) { described_class.result(url:) }

    context "with successfuly fetched page" do
      let(:url) { "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm" }

      it "returns page body" do
        VCR.use_cassette("alza-aeg-7000") do
          expect(fetch_page).to be_success
          expect(fetch_page.body).to be_kind_of(String)
        end
      end
    end

    context "with unsuccessful response" do
      let(:url) { "https://www.alza.cz/nonexistent" }

      it "fails the actor" do
        VCR.use_cassette("alza-fail") do
          expect(fetch_page).to be_failure
        end
      end
    end

    context "with invalid URL" do
      let(:url) { "invalid url" }

      it "fails" do
        expect(fetch_page).to be_failure
      end
    end
  end
end
