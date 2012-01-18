#= require jasmine/GWT/Background
#
class jasmine.GWT.Scenario extends jasmine.GWT.Background
  @runCode: (type, name, param, position, context, args = []) ->
    it "#{type} #{name}", ->
      if position == 'first'
        jasmine.GWT.runHook('World', context)
        jasmine.GWT.runHook('Before', context)

      this.spyOn = (args...) ->
        this.spies_ = context.spies_
        jasmine.Spec.prototype.spyOn.apply(this, args)

      this.removeAllSpies = ->
        if position == 'last'
            jasmine.Spec.prototype.removeAllSpies.apply(context)

      param.apply(context, args)

      if position == 'last'
        jasmine.GWT.runHook('After', context)

  @runFailure: (type, name, args) ->
    it "#{type} #{name}", ->
      output = [ "", "No step defined for #{type} #{name}. Define one using the following:", '' ]
      output = output.concat(jasmine.GWT.Scenario.generateStepDefinition(type, name, args))
      output.push("")

      this.addMatcherResult(
        jasmine.GWT.Scenario.generateNotDefinedResult(type, name, output.join("\n"))
      )

  @generateStepDefinition: (type, name, args) ->
    output = []

    argCount = args.length

    name = name.replace /\d+/g, (match) ->
      argCount += 1
      "(\\d+)"

    name = name.replace /\"[^"]+\"/g, (match) ->
      argCount += 1
      '"([^"]+)"'

    if argCount == 0
      output.push("#{type} /^#{name}$/, ->")
    else
      args = ("arg#{i}" for i in [ 1..(argCount) ])

      output.push("#{type} /^#{name}$/, (#{args.join(', ')}) ->")

    output.push("  @not_defined()")
    output

  @generateNotDefinedResult: (type, name, message) ->
    new jasmine.ExpectationResult(
      matcherName: 'step',
      passed: false,
      expected: 'to be defined',
      actual: "#{type} #{name}",
      message: message
    )

  constructor: (@scenarioName, @code, @feature) ->
    super(@code)

  run: =>
    super()

    jasmine.GWT.currentScenario_ = this

    _statements = this.allStatements()
    _this = this

    describe @feature.name, ->
      describe _this.scenarioName, ->
        _this.spies_ = []

        position = 'first'

        for index in [ 0..._statements.length ]
          [ type, name, param ] = _statements[index]
          [ _this._type, _this._name ] = [ type, name ]

          args = []

          codeRunner = (thing, args = []) ->
            jasmine.GWT.Scenario.runCode(type, name, thing, position, _this, args)

          if param?
            if typeof param == "function"
              codeRunner(param)

              continue
            else
              args = [ param ]

          found = false

          for [ match, code ] in (jasmine.GWT.Steps[type] || [])
            if result = name.match(match)
              codeRunner(code, result[1..-1].concat(args))
              found = true

              break

          jasmine.GWT.Scenario.runFailure(type, name, args) if !found

          position = (if (index + 2) == _statements.length then 'last' else 'middle')

    jasmine.GWT.currentScenario_ = null

  allStatements: =>
    allStatements = []

    if @feature.background?
      allStatements = @feature.background.statements

    allStatements.concat(@statements)

  not_defined: =>
    fakeResult = jasmine.GWT.Scenario.generateNotDefinedResult(@_type, @_name, 'has no code defined.')

    jasmine.getEnv().currentSpec.addMatcherResult(fakeResult)
