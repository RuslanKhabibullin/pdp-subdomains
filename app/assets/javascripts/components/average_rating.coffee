class App.Components.AverageRating extends App.Components.Base
  config:
    valueClass: ".js-rating-value"
    postUrl: "/posts/:post-id.json"
 
  bindUI: ->
    @ui =
      value: @$el.find(@config.valueClass)
 
  bindListeners: ->
    $(document).on("app:rating:fetch", @_updateAverageRating)
  
  _updateAverageRating: (_event, postId) =>
    $.ajax
      type: "GET"
      url: @config.postUrl.replace ":post-id", postId
      success: @_onSuccess
      error: @_onFailure

  _onSuccess: (postObject) =>
    averageRating = postObject["average_rating"]
    @ui.value.text(averageRating)
    $(document).trigger("app:rating:fetch:success", averageRating)

  _onFailure: (_XMLHttpRequest, _textStatus, errorThrown) ->
    $(document).trigger("app:modal:error", errorThrown)

$ ->
  new App.Components.AverageRating($(el)) for el in $(".js-average-rating")
