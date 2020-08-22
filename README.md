# FormReflex
FormReflex is a light extension of [optimism](https://optimism.leastbad.com/), leveraging [stimulus_reflex](https://docs.stimulusreflex.com/).

FormReflex provides real time form validation on change, using the validations already provided on your model.

## Usage

Please follow the setup instructions for optimism [here](https://optimism.leastbad.com/quick-start)

Usage for FormReflex is *identical* to the optimism usage, with 2 exceptions:

1) You must specify data-reflex="change->FormReflex#handle_change" on your form control

```erb
data-reflex="change->FormReflex#handle_change"
```

2) The model you want to validate must be initialized in session[:model]

For example:

```ruby
def new
  @post = Post.new
  session[:model] = @post unless @stimulus_reflex
end

private
def set_post
  @post = Post.find(params[:id])
  session[:model] = @post unless @stimulus_reflex
end
``` 

All in all, pulling in [Optimism's](https://optimism.leastbad.com/) own example, it would look like this:

```erb
<%= form_with(model: session[:model]) do |form| %>
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
