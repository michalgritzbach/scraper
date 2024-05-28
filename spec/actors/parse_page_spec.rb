require "rails_helper"

RSpec.describe ParsePage do
  describe ".result" do
    subject(:parse_page) { described_class.result(body:) }

    context "with successfuly fetched page" do
      let(:body) do
        VCR.use_cassette("alza-aeg-7000") do
          HTTParty.get("https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm")
        end.body
      end

      it "returns parsed document" do
        expect(parse_page).to be_success
        expect(parse_page.parsed).to be_kind_of(Nokogiri::XML::Document)
      end
    end
  end
end
