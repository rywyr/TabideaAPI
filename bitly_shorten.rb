require 'bitly'
 
def bitly_shorten(url)
  Bitly.use_api_version_3
  Bitly.configure do |config|
    config.api_version = 3
    config.access_token = "R_70f03435c0e848e393d01bdc45990cc4"
  end
  Bitly.client.shorten(url).short_url
end