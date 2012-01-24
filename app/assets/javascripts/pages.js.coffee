# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(document).ready ->
  jQuery("#micropost_content").bind "keyup change", ->
    char_count = $(this).val().length
    remain_count = 140 - char_count
    remain_count = 0 if remain_count < 0
    $("#text_remaining").html remain_count + " remaining character(s)"
