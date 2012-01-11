class jasmine.GWT.Background
  constructor: (code) ->
    @statements = []

    jasmine.GWT.currentScenario_ = this

    code.apply(this)

    jasmine.GWT.currentScenario_ = null

  Given: (name, code) ->
    @statements.push([ 'Given', name, code ])
  When: (name, code) ->
    @statements.push([ 'When', name, code ])
  Then: (name, code) ->
    @statements.push([ 'Then', name, code ])

