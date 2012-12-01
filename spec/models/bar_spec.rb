require 'spec_helper'
gem 'simplecov'
SimpleCov.start

describe Bar do
  before(:each) do
    Bar.destroy_all
    @test_bar = FactoryGirl.create(:bar)
  end

  it "should be unique" do
    # bar1 = FactoryGirl.create(:bar)
    bar2 = FactoryGirl.build(:bar)
    bar2.should_not be_valid
  end

  it "should have a longitude"


  it "should have a latitude"
  

  describe "zipcode" do
    before(:each) do
      @zip_codes = %w[9 91 912 9134 9a891 231234 2-9038 31093-192 1392-1293]
      @zip_codes.each do |invalid_zip_code|
        @test_bar.zip_code = invalid_zip_code
      end
    end

    it "should have a proper zip code" do
      @test_bar.should_not be_valid
    end

    it "should raise an error if invalid zip code" do
      @test_bar.error_on(:zip_code).should == ["Thats not a valid zipcode buddy!"]
    end
  end

  describe "name" do
    before(:each) do
      @test_bar.name = nil
    end
    
    it "should have a name" do
      @test_bar.should_not be_valid
    end

     it "should raise an error if invalid name" do    
      @test_bar.error_on(:name).should == ["You forgot your name!"]
    end
  end
  
  describe "locations" do
    before(:each) do
      @test_bar_array = Bar.locations([@test_bar])
    end

    it "should have the correct longitude" do
      @test_bar.longitude.should == @test_bar_array[0][:longitude]
    end

    it "should have a correct latitude" do
      @test_bar.latitude.should == @test_bar_array[0][:latitude]
    end

    it "should have a valid longitude" do
      @test_bar.latitude.should_not be_nil
    end

    it "should have a valid latitude" do      
      @test_bar.latitude.should_not be_nil
    end

  end

  describe "unique_on_address" do
    before(:each) do
      @bar2 = FactoryGirl.build(:bar)
      @bar2.name = "Bar Name"
    end

    it "should not save to database" do
      @bar2.should_not be_valid
    end
  end

  describe "find_by_games" do
    it "should find a bar by game id" do
      Bar.find_by_games(1).should == Bar.first
    end
  end
end