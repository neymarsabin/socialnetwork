$ ->
  $("[data-remote]").on "ajax:success",(e, data, status, xhr) ->
    alert "The post was voted"
