jasmine.GWT =
  Step: (type, name, parameter) ->
    if scenario = jasmine.GWT.currentScenario_
      scenario[type](name, parameter)
    else
      jasmine.GWT.Steps[type] ||= []
      jasmine.GWT.Steps[type].push([ name, parameter ])
  Hook: (type, code) ->
    jasmine.GWT.Hooks[type] ||= []
    jasmine.GWT.Hooks[type].push(code)

  runHook: (type, context) ->
    for code in (jasmine.GWT.Hooks[type] || [])
      code.apply(context)

  Steps: {}
  Hooks: {}
