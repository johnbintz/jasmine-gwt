class jasmine.GWT.Background
  constructor: (@code) ->
    @statements = []

  run: =>
    jasmine.GWT.currentScenario_ = this

    @code.apply(this)

    jasmine.GWT.currentScenario_ = null

  Given: (name, code) => this.Step('Given', name, code)
  When: (name, code) => this.Step('When', name, code)
  Then: (name, code) => this.Step('Then', name, code)

  Step: (type, name, code) =>
    @statements.push([ type, name, code ])

