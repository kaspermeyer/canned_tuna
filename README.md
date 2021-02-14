# Canned Tuna

> 🚧 Under construction. Expect unstable API on versions less than 0.1.0  🚧

Organizing content in Prawn gets notoriously difficult as the size and complexity of the document increases. This often leads to a junk drawer of helper methods and mixins that is hard to maintain.

Components are an antidote to this approach. They encapsulate a self-contained piece of content which can be drawn in any document. This makes them easy to test and reuse.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'canned_tuna'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install canned_tuna

## Example
```ruby
class Box < CannedTuna::Component
  template do
    bounding_box([0, cursor - 100], width: width, height: height) do
      outlet
      draw_border
    end
  end

  attr_reader :width, :height

  def initialize(width: 100, height: 100)
    @width, @height = width, height
  end

  def draw_border
    transparent(0.5) { stroke_bounds }
  end
end

Prawn::Document.generate("box.pdf") do
  draw Box, width: 200, height: 100 do
    text "Inside the box"
  end
end
```

## Outlets

### Default outlet
Components can define a single content outlet by using the `outlet` helper inside the template:

```ruby
class Panel < CannedTuna::Component
  template do
    outlet
  end
end

Prawn::Document.generate("single_outlet.pdf") do
  draw Panel do
    text "Inside the panel"
  end
end
```

### Named outlets
Components can define multiple content outlets by passing their names to the `outlet` helper:

```ruby
class Panel < CannedTuna::Component
  template do
    outlet(:header)
    outlet(:body)
    outlet(:footer)
  end
end

Prawn::Document.generate("multiple_outlets.pdf") do
  draw Panel do |content|
    content.outlet(:header) do
      text "I am the header"
    end
    content.outlet(:body) do
      text "I am the body"
    end
    content.outlet(:footer) do
      text "I am the footer"
    end
  end
end
```

### Default content
Components can define default content for their outlets by yielding a block to the `outlet` helper:

```ruby
class Panel < CannedTuna::Component
  template do
    outlet(:header) { text "I am the header" }
    outlet(:body)
    outlet(:footer) { text "I am the footer" }
  end
end

Prawn::Document.generate("default_content.pdf") do
  draw Panel do |content|
    content.outlet(:body) do
      text "I am the body"
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaspermeyer/canned_tuna.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
