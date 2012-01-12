jasmine.GWT.globals =
  Feature: (args...) ->
    new jasmine.GWT.Feature(args...)

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

