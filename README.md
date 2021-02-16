NOTE: Be careful, this is the beta-version. Specifically, this doesn't have any test codes. 😭

# Freee::Pigmon

Request Freee time clocking with CLI.

![image](https://vignette.wikia.nocookie.net/ultra/images/b/b9/Max_pigmon.png/revision/latest?cb=20111211083202)

## Installation

Clone this repo.

    $ git clone git@github.com:xxxx/freee-pigmon.git

And then execute:

    $ gem build freee-pigmon.gemspec

Finally install it.

    $ gem install freee-pigmon

## Usage

Note: You can see simple descriptions about commands with below command:

    $ freee-pigmon

### Register Code

First, you have to get authorize key from [Here](https://accounts.secure.freee.co.jp/public_api/authorize?client_id=a213888077faae573fdba8e5d7787448e84efbf5e9ca6584035deac9f74508a4&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code).

Then, register access tokens using the key.

    $ freee-pigmon set_code {code}

This is just once task of OAuth2.

### clock in 

Note: Be careful, you can do this just once in a day.

    $ freee-pigmon clock_in

### clock out 

Note: Be careful, you can do this just once in a day and only after clock-in.

    $ freee-pigmon clock_out

### break

You can request as below.

    $ freee-pigmon break_begin

    $ freee-pigmon break_end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/degica/freee-pigmon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Freee::Pigmon project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/freee-pigmon/blob/master/CODE_OF_CONDUCT.md).
