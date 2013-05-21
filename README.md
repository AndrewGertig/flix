# Flix

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'flix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flix

## Usage

Example of creating a Class to use Flix:

````ruby
class NFlix
    
  ##### Flix Gem
  
  def self.flix_client(user)
    Flix.configure do |config|
      config.consumer_key = NETFLIX_CONSUMER_KEY
      config.consumer_secret = NETFLIX_CONSUMER_SECRET
      config.oauth_token = user.netflix_key
      config.oauth_token_secret = user.netflix_secret
      config.uid = user.netflix_uid
    end
    
    return Flix
  end
  
end
````



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
