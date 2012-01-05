`jasmine-gwt` provides a cool Given-When-Then syntax not dissimilar to [Cucumber](http://cukes.info/), but
running entirely in [Jasmine](http://pivotal.github.com/jasmine/). No other dependencies (except CoffeeScript,
but that'll change.) Also, writing these in CoffeeScript gives you an experience really close to Cucumber, so yeah.

Import the library, say by using Sprockets in your `spec_helper.js.coffee`:

``` coffeescript
#= require jasmine-gwt
#= require_tree ./steps
```

Then create some features for a thing:

``` coffeescript
Feature 'Complex Backbone View', ->
  Background ->
    Given 'I have a model', ->
      @model = new Backbone.Model()
    Given 'I have a view', ->
      @view = new ComplexBackboneView(model: @model)

  Scenario 'Basics', ->
    When 'I render the view'
    Then 'the view should return itself'
    Then 'the view should contain ".loader"'

  Scenario 'Model has a name', ->
    Given 'the model has the name "John"'
    When 'I render the view'
    Then 'the view has ".name" with the text "John"'
```

Run it and you'll be told you need to define some steps, Cucumber-style:

``` coffeescript
When /I render the view/, ->
  @result = @view.render()

Then /the view should return itself/, ->
  expect(@result).toEqual(@view)

Then /the view should contain "([^"]+)"/, (selector) ->
  expect($(@view.el)).toContain(selector)

Given /the model has the name "([^"]+)"/, (name) ->
  @model.set(name: name)

Then /the view has the "([^"]+)" with the text "([^"]+)"/, (selector, text) ->
  expect(view.$(selector)).toHaveText(text)
```

If you give a step a callback in the `Scenario` or `Background` block, it'll just run that code.

Then write your usual Jasmine specs to test from bottom-up, and use the features to test from the top-down.
It's awesome! Errors are reported along with the rest of your Jasmine specs, since `jasmine-gwt` just generates
`describe` and `it` blocks for each of the steps.

You also have `Before` and `After` hooks for each scenario. Here's a handy one for Sinon.JS fake server support.

```
Before ->
  @server = sinon.fakeServer.create()

After ->
  @server.restore()
```

*Important*: Use single-arrows when defining steps. Each block of code is executed in the same context, and mucking
with that would make thing probably not work too well.

## Why not another GWT library, or Cucumber itself?

I wanted something that worked as much like Cucumber as possible without actually bringing in Cucumber. Bringing in
Cucumber into my toolchain would be more work right now than I want to deal with (making `jasmine-headless-webkit` support
CommonJS `require`, for instance), but I also wanted as much of the cool magic that Cucumber had. Therefore, this library.

Todo:

* Test the code (I cowboyed it! Yeehaw!)
* Step hooks (`BeforeEach` and `AfterEach`)
* Tagged scenarios
* Hooks that only react to certain tags

So alpha it's pretty much the letter before alpha.

