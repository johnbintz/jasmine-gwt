jasmine.GWT.globals =
  Feature: (args...) ->
    feature = new jasmine.GWT.Feature(args...)
    feature.run()

  Background: (args...) ->
    jasmine.GWT.currentFeature_.Background(args...)

  Scenario: (args...) ->
    jasmine.GWT.currentFeature_.Scenario(args...)

  Given: (args...) ->
    @_lastType = 'Given'
    jasmine.GWT.Step(@_lastType, args...)

  When: (args...) ->
    @_lastType = 'When'
    jasmine.GWT.Step(@_lastType, args...)

  Then: (args...) ->
    @_lastType = 'Then'
    jasmine.GWT.Step(@_lastType, args...)

  And: (args...) ->
    jasmine.GWT.Step(@_lastType, args...)

  Before: (args...) -> jasmine.GWT.Hook('Before', args...)
  After: (args...) -> jasmine.GWT.Hook('After', args...)

  World: (args...) -> jasmine.GWT.World(args...)

