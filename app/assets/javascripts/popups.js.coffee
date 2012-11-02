#=require 'html_builder'

window.exports or= this

class Popups
  @initialize: ->
    $.rails.confirm = -> true
    $("a[data-confirm]").each -> Popups.Confirm.make_link_confirmable($ @)
    
class Popups.Base
  constructor: (@title="Title", @content="content", @buttons={ok: "OK"}, @callback)->
    @build_modal_html()
    @attach_events()
    @show_modal()

  build_modal_html: ->
    me = @
    @elm = HtmlBuilder.tag 'div', class: 'modal', ->
      @tag 'div', class: 'modal-header', ->
        @tag 'a', class: 'close', 'data-dismiss': 'modal', '×'
        @tag 'h3', me.title
      @tag 'div', class: 'modal-body', ->
        @tag 'p', me.content
      @tag 'div', class: 'modal-footer', ->
        @tag 'a', href: '{}', class: 'btn', 'data-button':button_name, button_text for button_name,button_text of me.buttons
    @elm.find(".btn:first").addClass("btn-primary")
        
  attach_events: ->
    @elm.find("a.btn").click   (e)=> @did_click_button(e)
    @elm.find("a.close").click (e)=> @callback.call(@,null,@) if @callback

  show_modal: ->
    @elm.modal('show')
  
  did_click_button: (e)->
    btn = $(e.target || e.currentTarget)
    @callback.call(@,btn.data("button"),@) if @callback
    @elm.modal('hide')
    e.preventDefault()
    false
  
class Popups.Alert extends Popups.Base
  constructor: (title="Warning", message="Alert!", ok_text="OK", callback) ->
    super title, message, {ok: ok_text}, callback
    
class Popups.Confirm extends Popups.Base
  constructor: (title="Warning", message="Are you sure?", yes_text="Yes", no_text="No" , callback)->
    super title, message, {yes: yes_text, no: no_text}, callback
  
  @make_link_confirmable: (elm)->
    elm.click (e)->
      elm = $ @
      return true if elm.data 'confirmed'
      data = elm.data 'confirm'
      new Popups.Confirm data.title, data.message, data.yes, data.no, (button)=>
        elm.data('confirmed',true).click() if button == 'yes'
      e.preventDefault()
      false
      

exports.Popups = Popups

$ exports.Popups.initialize
