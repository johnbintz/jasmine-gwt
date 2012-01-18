#= require jquery
#
this.Cabiai =
  wrapException: (view, message) ->
    throw new Error("#{message}\nin: #{$(view).html()}")

  Actions:
    _view: -> Cabiai.viewSource.apply(this)

    clickOn: (text) ->
      found = false

      $('button', @_view()).each (index, element) =>
        if !found and $(element).text() == text
          $(element).click()

          found = true

      Cabiai.wrapException(@_view(), "Button not found: #{text}") if !found

    within: (selector, callback) ->
      preservedView = @_view
      view = $(selector, @_view())
      @_view = -> view

      callback.apply(this)

      @_view = preservedView

