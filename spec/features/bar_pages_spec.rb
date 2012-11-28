require 'spec_helper'

describe "Bar pages", :js => true do
  let!(:bar) { create(:bar) }
  subject { page }

  describe "bar info page" do
    before(:each) do 
      visit bar_path(bar)
    end

    it "should have the bar name" do 
      should have_selector('h1', text: bar.name) 
    end

    it "should have the bar image" do
      find('.bar-image img').visible?.should be_true
    end

    context 'bar attributes' do
      it "should have bar's number of screens" do
        find('.bar-attributes').should have_content(bar.num_of_screens)
      end

      it "has fan intensity rating" do
        find('.bar-attributes .bar-details').should have_content(bar.fan_intensity_rating)
      end

      it "has bar address" do
        find('.bar-attributes').should have_content(bar.address)
      end

      it "has bar city" do
        find('.bar-attributes').should have_content(bar.city)
      end

      it "has bar state" do
        find('.bar-attributes').should have_content(bar.state)
      end

      it "has bar zip code" do
        find('.bar-attributes').should have_content(bar.zip_code)
      end

      it "has bar neighborhood" do
        find('.bar-attributes').should have_content(bar.neighborhood)
      end
    end
  end
end