$ ->
  $(".notice, .error").on("click", (event)->
    $(event.target).hide("slow")
  )
