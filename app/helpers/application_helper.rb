module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then 'info'
      when :error then 'error'
      when :alert then 'warning'
    end
  end

  def icon_tag *args
    content_tag :i , "", class: args.flatten.map{|cls| "icon-#{cls}"}.join(" ")
  end
  
  def button_link_to text, path, options = {}
    icons_map = {new: 'plus-sign', edit: 'pencil', destroy: 'trash', list: 'list'}
    icon = options.delete(:icon)
    icon_color = options.delete(:icon_color) || 'white'
    size = options.delete(:size) || 'small'
    type = options.delete(:type) || 'info'
    options[:class] = [options[:class], "btn-#{size}", "btn", "btn-#{type}"].join(" ")
    link_to (icon.present? ? icon_tag(icons_map[icon]||icon, icon_color).safe_concat(" #{text}") : text), path, options
  end

end
