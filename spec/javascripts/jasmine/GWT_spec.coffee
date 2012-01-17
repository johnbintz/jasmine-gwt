describe 'jasmine.GWT', ->
  describe '.Step', ->
    type = 'type'
    name = 'name'
    parameter = 'parameter'

    beforeEach ->
      jasmine.GWT.Steps = {}

    context 'no running scenario', ->
      beforeEach ->
        jasmine.GWT.currentScenario_ = null

      it 'should add the step to the available steps list', ->
        jasmine.GWT.Step(type, name, parameter)

        expect(jasmine.GWT.Steps[type]).toEqual([ [ name, parameter ] ])

    context 'running scenario', ->
      beforeEach ->
        jasmine.GWT.currentScenario_ = {}
        jasmine.GWT.currentScenario_[type] = ->

        spyOn(jasmine.GWT.currentScenario_, type)

      it 'should run the code in the scenario', ->
        jasmine.GWT.Step(type, name, parameter)

        expect(jasmine.GWT.currentScenario_[type]).toHaveBeenCalledWith(name, parameter)

  describe '.Hook', ->
    type = 'type'
    code = 'code'

    beforeEach ->
      jasmine.GWT.Hooks = {}

    it 'should add the hook', ->
      jasmine.GWT.Hook(type, code)

      expect(jasmine.GWT.Hooks[type]).toEqual([ code ])

  describe '.World', ->
    worldMethods = 'worldMethods'

    beforeEach ->
      spyOn(jasmine.GWT, 'Hook')
      spyOn(jasmine.GWT, 'generateWorldMethods').andReturn(worldMethods)

    context 'with object', ->
      object = {}

      it 'should add an object that adds methods to the World', ->
        jasmine.GWT.World(object)
        expect(jasmine.GWT.Hook).toHaveBeenCalledWith('World', worldMethods)

    context 'with function', ->
      func = ->

      it 'should add the function to the queue', ->
        jasmine.GWT.World(func)
        expect(jasmine.GWT.Hook).toHaveBeenCalledWith('World', func)

