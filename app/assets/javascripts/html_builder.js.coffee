window.exports or= this

class HtmlBuilder

  constructor: (tag_name, args...)->
    attributes = if $.isPlainObject args[0] then args.shift() else {}
    content = if $.isFunction args[0] then "" else args.shift()
    func = args.shift() if $.isFunction args[0]
    @root = $("<#{tag_name}>")
    @root.html content
    @root.attr(k,v) for k,v of attributes
    func.apply @ if func
    @root
  
  tag: ()->
    hb = Object.create HtmlBuilder.prototype
    hb = HtmlBuilder.apply(hb, arguments) || hb
    @root.append hb.root

  @tag: () ->
    hb = Object.create HtmlBuilder.prototype
    hb = HtmlBuilder.apply(hb, arguments) || hb
    hb.root  
  

exports.HtmlBuilder = HtmlBuilder