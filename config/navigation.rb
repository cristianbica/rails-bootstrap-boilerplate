# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|

  navigation.selected_class = 'active'
  
  navigation.items do |primary|

    primary.dom_class = "nav"
    primary.item :dashboard, 'Dashboard', dashboard_show_path

  end

end

