# Prawn::Component

> 🚧 Under construction. More documentation to come  🚧

Organizing content in Prawn gets notoriously difficult as the size and complexity of the document increases. This often leads to a junk drawer of helper methods and mixins that is hard to maintain.

Components are an antidote to this approach. They encapsulate a self-contained piece of content which can be drawn in any document. This makes them easy to test and reuse.

## Example
```ruby
class Box < Prawn::Component
  template do |component, content|
    bounding_box([0, cursor - 100], width: component.width, height: component.height) do
      content.call
      transparent(0.5) { stroke_bounds }
    end
  end

  attr_reader :width, :height

  def initialize(width: 100, height: 100)
    @width, @height = width, height
  end
end

Prawn::Document.generate("box.pdf") do
  component Box, width: 200, height: 100 do
    text "Inside the box"
  end
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prawn-component'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prawn-component

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/prawn-component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
