class jasmine.GWT.Feature
  constructor: (@name, @code) ->

  run: =>
    jasmine.GWT.currentFeature_ = this

    @background = null
    @code.apply(this)

    jasmine.GWT.currentFeature_ = null

  Scenario: (name, code) ->
    scenario = new jasmine.GWT.Scenario(name, code, this)
    scenario.run()

  Background: (code) ->
    @background = new jasmine.GWT.Background(code)
    @background.run()

