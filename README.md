# RakutenSecuritiesScraper

Rakuten Securities Scraper / 楽天証券スクレイパー
This gem is providing scraper methods for everyone to be able to make stock trading applications without writing scraper codes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rakuten_securities_scraper"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rakuten_securities_scraper

## Usage

```ruby
    include RakutenSecuritiesScraper
    data = RakutenScraper.new($LOGIN_ID, $LOGIN_PW)

    ## Get Today's Trade History
    puts data.todays_history

    ## Get All Trade History
    puts data.all_history

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elsoul/rakuten_securities_scraper.

