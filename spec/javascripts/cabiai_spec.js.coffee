#= require cabiai
#
describe 'Cabiai', ->
  cabiai = null

  beforeEach ->
    Cabiai.viewSource = -> @view

    cabiai = {}

    cabiai[method] = code for method, code of Cabiai.Actions

  describe 'Actions#clickOn', ->
    context 'button', ->
      text = "text"
      isClicked = false

      beforeEach ->
        cabiai.view = $("<div><button>#{text}</button></div>")
        $('button', cabiai.view).click -> isClicked = true

      it 'should find a button by text', ->
        cabiai.clickOn(text)
        expect(isClicked).toEqual(true)

      it 'should not find it' , ->
        try
          cabiai.clickOn('other')
          expect("throw exception").toEqual(false)
        catch e
          expect(e.message).toMatch(/Button not found: other/)

  describe 'Actions#within', ->
    beforeEach ->
      cabiai.view = $('<div><li>One</li><li>Two</li></div>')

    it 'should focus an action within a selector', ->
      currentView = null

      cabiai.within 'li:eq(1)', ->
        currentView = this._view()

      expect(currentView).toEqual($('li:eq(1)', cabiai.view))


