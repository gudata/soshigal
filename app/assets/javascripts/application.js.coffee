#= require libraries
#= require_tree ./templates
#= require albums
#= require comments
#= require images
#= require sources

$ ->
  $('.alert').delay(4000).fadeOut('slow')
  $('.chosen').chosen()
  $('.timeago').timeago()

# Have a loading screen when turbolinks is working it's magic
document.addEventListener 'page:fetch', ->
  html = "<div id='loading'><div><i class='icon-spinner icon-spin icon-4x'></i></div></div>"
  $('body').prepend(html)

document.addEventListener 'page:receive', ->
  $('#loading').remove()
