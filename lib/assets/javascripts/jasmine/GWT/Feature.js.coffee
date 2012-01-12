class jasmine.GWT.Feature
  constructor: (@name, code) ->
    jasmine.GWT.currentFeature_ = this

    @background = null
    code.apply(this)

    jasmine.GWT.currentFeature_ = null

  Scenario: (name, code) ->
    new jasmine.GWT.Scenario(name, code, this)

  Background: (code) ->
    @background = new jasmine.GWT.Background(code)

