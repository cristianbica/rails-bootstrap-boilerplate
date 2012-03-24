#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require_tree .

window.nil = null
window.App or= {}

$ ->
  $(".translation_missing").each ()->
    console.error($(this).attr('title'))
  