require 'rails_helper'

RSpec.describe "Companies", type: :request do
  describe "GET /companies" do
    let(:company) { Company.new(name: "Chase") }

    it "is valid" do
      expect(company).to be_valid
    end

    it 'is invalid without a name' do
      company.name = nil
      expect(company).to_not be_valid
    end

  end
end
