# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#new_issue, #issues_index, .edit_issue_link, .destroy_issue, #issues .show_path', ->
  cloak '#container'

$(document).on 'click', '#issues_index', ->
  window.history.replaceState( {} , '', '/issues' );
