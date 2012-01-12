#= require jasmine/GWT/Background
#
class jasmine.GWT.Scenario extends jasmine.GWT.Background
  constructor: (scenarioName, code, @feature) ->
    super(code)

    _statements = this.allStatements()
    _this = this

    describe @feature.name, ->
      describe scenarioName, ->
        _this.spies_ = []

        for index in [ 0..._statements.length ]
          [ type, name, param ] = _statements[index]

          _this._type = type
          _this._name = name

          runCode = (param, index, args = []) ->
            isLast = (index + 1) == _statements.length
            isFirst = (index == 0)

            it "#{type} #{name}", ->
              if isFirst
                jasmine.GWT.runHook('Before', _this)

              this.spyOn = (args...) ->
                this.spies_ = _this.spies_
                jasmine.Spec.prototype.spyOn.apply(this, args)

              this.removeAllSpies = ->
                if isLast
                  jasmine.Spec.prototype.removeAllSpies.apply(_this)

              param.apply(_this, args)

              if isLast
                jasmine.GWT.runHook('After', _this)

          args = []

          if param?
            if typeof param == "function"
              runCode(param, index)
              continue
            else
              args = [ param ]

          found = false

          if jasmine.GWT.Steps[type]
            for [ match, code ] in jasmine.GWT.Steps[type]
              if match.constructor == RegExp
                if result = name.match(match)
                  result.shift()
                  runCode(code, index, result.concat(args))
                  found = true

                  break
              else
                if name == match
                  runCode(code, index)
                  found = true

                  break

            if !found
              output = [ "", "No step defined for #{type} #{name}. Define one using the following:", '' ]

              argCount = args.length

              name = name.replace /\d+/g, (match) ->
                argCount += 1
                "(\\d+)"

              name = name.replace /\"[^"]+\"/g, (match) ->
                argCount += 1
                '"([^"]+)"'

              if argCount == 0
                output.push("#{type} /#{name}/, ->")
              else
                args = ("arg#{i}" for i in [ 1..(argCount) ])

                output.push("#{type} /#{name}/, (#{args.join(', ')}) ->")

              output.push("  @not_defined()")
              output.push("")

              fakeResult = new jasmine.ExpectationResult(
                matcherName: 'steps',
                passed: false,
                expected: 'to be defined',
                actual: "#{type} #{name}",
                message: output.join("\n")
              )

              jasmine.getEnv().currentSpec.addMatcherResult(fakeResult)

  allStatements: =>
    allStatements = []

    if @feature.background?
      allStatements = @feature.background.statements

    allStatements.concat(@statements)

  not_defined: =>
    fakeResult = new jasmine.ExpectationResult(
      matcherName: 'step',
      passed: false,
      expected: 'to be defined',
      actual: "#{@_type} #{@_name}",
      message: "has no code defined."
    )

    jasmine.getEnv().currentSpec.addMatcherResult(fakeResult)
