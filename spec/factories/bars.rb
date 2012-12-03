FactoryGirl.define do
  factory :bar do
    name                  "Public House"
    image_link            "http://s3-media3.ak.yelpcdn.com/bphoto/R3oLUIVQ7XLbiqEEEJKy8Q/l.jpg"
    fan_intensity_rating  8
    num_of_screens        12
    latitude              37.7653419
    longitude             -122.410774
    address               "717 California"
    city                  "San Francisco"
    state                 "CA"
    zip_code              "94109"
    neighborhood          "Chinatown"
  end
end
