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

You can use omniauth-netflix to auth with Netflix and get a user's netflix\_key, netflix\_secret, and netflix\_uid

In an initializer like omniauth.rb

````ruby
provider :netflix, NETFLIX_CONSUMER_KEY, NETFLIX_CONSUMER_SECRET
````

This was in my User model user.rb

````ruby

def apply_netflix(auth)
  puts "Did you Make it To NETFLIX: #{auth['info']}"
  self.name = auth["info"]["name"]
  self.username = auth["info"]["nickname"]
  self.role = auth["provider"]
                        
  credentials = auth["credentials"]
  authentications.build(:provider => auth["provider"], 
                        :uid => auth["uid"],
                        :access_token => credentials.token,
                        :access_secret => credentials.secret)
end

````

Example of creating a Class to use Flix:

````ruby
class NFlix
  
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

Then you can create an instance of Flix in a controller

````ruby
@flix = NFlix.flix_client(current_user)
````

Then in a view you can access Netflix like this

````erb

<% if @flix.user %>
  <div class="row">
    <h2>Netflix User</h2>
    <pre>
      <%= @flix.user["first_name"] %> <%= @flix.user["last_name"] %>
    </pre>
  </div>

  <div class="row">
      <h2>Netflix Instant Queue</h2>
      <% @flix.instant_queue.each do |queue_item| %>
        <pre>
          <img src="<%= queue_item["box_art"]["medium"] %>">
          <%= queue_item["title"]["short"] %>
        </pre>
      <% end %>
  </div>
<% end %>

````



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
