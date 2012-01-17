jasmine.GWT =
  Step: (type, name, parameter) ->
    if scenario = jasmine.GWT.currentScenario_
      scenario[type](name, parameter)
    else
      (jasmine.GWT.Steps[type] ||= []).push([ name, parameter ])

  Hook: (type, code) ->
    (jasmine.GWT.Hooks[type] ||= []).push(code)

  World: (object_or_code) ->
    if typeof object_or_code != 'function'
      object_or_code = jasmine.GWT.generateWorldMethods(object_or_code)

    jasmine.GWT.Hook('World', object_or_code)

  runHook: (type, context) ->
    for code in (jasmine.GWT.Hooks[type] || [])
      code.apply(context)

  generateWorldMethods: (object) ->
    ->
      for method, code of object
        this[method] = code

  Steps: {}
  Hooks: {}
