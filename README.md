# FormReflex
FormReflex is a light extension of [optimism](https://optimism.leastbad.com/), leveraging [stimulus_reflex](https://docs.stimulusreflex.com/).

FormReflex provides real time form validation on change, using the validations already provided on your model.

## Usage

Please follow the setup instructions for optimism [here](https://optimism.leastbad.com/quick-start)

Usage for FormReflex is *identical* to the optimism usage, with the exception that your form control must have this additional attribute:

```erb
data-reflex="change->FormReflex#handle_change"
```

So, pulling in [Optimism's](https://optimism.leastbad.com/) own example, it would look like this:

```erb
<%= form_with(model: post) do |form| %>
  <div class="field">
    <%= form.label :name %>
    <%= form.text_field :name, data: { reflex: "change->FormControl#handle_change" } %>
    <%= form.error_for :name %>
  </div>

  <div class="field">
    <%= form.label :body %>
    <%= form.text_area :body, data: { reflex: "change->FormControl#handle_change" } %>
    <%= form.error_for :body %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'form-reflex'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install form-reflex
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
