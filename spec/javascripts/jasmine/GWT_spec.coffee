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

