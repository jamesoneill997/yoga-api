require 'rails_helper'

RSpec.describe "Searches", type: :request do
    before(:all) do
        # Load seed data
        Rails.application.load_seed
    end
  
    describe "GET /search?type=name&query=archer" do
        it "gets a pose" do
        get searches_path, params: { type: 'name', query: 'archer' }
        expect(response).to have_http_status(200)
        end
        it "returns a valid pose" do
            get searches_path, params: { type: 'name', query: 'archer' }
            expect(response.body).to include("Archer")
        end
    end
    
    describe "GET /search?type=name&query=blissful" do
        it "gets a pose from an alternative name" do
            get searches_path, params: { type: 'name', query: 'blissful' }
            expect(response.body).to include("Happy")
        end  
    end

    describe "GET /search?type=category&query=seated" do
        it "has more than 0 results" do
            get searches_path, params: { type: 'category', query: 'seated' }
            parsed_response = JSON.parse(response.body)
            expect(parsed_response.length).to be > 0
        end

        it "gets a pose by category" do
            get searches_path, params: { type: 'category', query: 'seated' }
            parsed_response = JSON.parse(response.body)
            expect(parsed_response[0]["category"]).to eq("seated")
        end
    end

    describe "GET /search?type=level&query=beginner" do
        it "has more than 0 results" do
            get searches_path, params: { type: 'level', query: 'beginner' }
            parsed_response = JSON.parse(response.body)
            expect(parsed_response.length).to be > 0
        end

        it "gets a pose by level" do
            get searches_path, params: { type: 'level', query: 'beginner' }
            parsed_response = JSON.parse(response.body)
            expect(parsed_response[0]["difficulty"]).to eq("beginner")
        end
    end
end
