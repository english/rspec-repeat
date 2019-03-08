# RSpec::Repetitive

Repeat RSpec examples with custom setup.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-repetitive'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-repetitive

## Usage

The following RSpec example would run twice: first without then with a feature switch enabled.

```rb
require 'rspec'
require 'rspec-repetitive'

RSpec.configure do |config|
  RSpec::Repetitive.configure(config)
end

RSpec.describe "something that should work with and without a feature switch enabled" do
  repeat_each_example "with my_feature enabled" do
    FeatureSwitch.enable(:my_feature)
  end

  it "works" do
    # ...
  end
end
```

Running the above example would produce the following:

```
$ rspec my_spec.rb

something that should work with and without a feature switch enabled
  works
  with my_feature enabled works

Finished in 0.00153 seconds (files took 0.12087 seconds to load)
2 examples, 0 failures
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
