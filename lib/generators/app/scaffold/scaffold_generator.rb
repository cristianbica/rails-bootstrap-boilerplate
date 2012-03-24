require 'rails/generators'
require 'rails/generators/generated_attribute'

module App
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::Base
      source_root File.expand_path("templates", File.dirname(__FILE__))
      argument :controller_path,    :type => :string
      #argument :model_name,         :type => :string, :required => false

      #hook_for :model , in: :rails
      #  do |orm|
      #   invoke active_record, [@model_name]
      # end
      
      hook_for :assets , in: :rails do |assets|
        invoke assets, [controller_path]
      end

      def initialize(args, *options)
        super(args, *options)
        initialize_views_variables
      end

      def copy_views
        generate_views
      end
      
      def copy_controller
        generate_controller
      end
      
      def copy_locale_file
        generate_locale_file
      end
      
      def add_route
        route_config =  @controller_class_path.collect{|namespace| "namespace :#{namespace} do" }
        route_config << "resources :#{@base_name}"
        route_config << ["end"] * @controller_class_path.size
        route route_config.flatten.join("\n")
      end

      protected

      def initialize_views_variables
        @base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(controller_path)
        @controller_routing_path = @controller_file_path.gsub(/\//, '_')
        @model_name = @controller_class_nesting + "::#{@base_name.singularize.camelize}" unless @model_name
        @model_name = @model_name.camelize
      end

      def controller_routing_path
        @controller_routing_path
      end

      def singular_controller_routing_path
        @controller_routing_path.singularize
      end

      def model_name
        @model_name
      end

      def plural_model_name
        @model_name.pluralize
      end

      def resource_name
        @model_name.demodulize.underscore
      end

      def plural_resource_name
        resource_name.pluralize
      end

      def columns
        @columns ||= begin
          excluded_column_names = %w[id created_at updated_at]
          @model_name.constantize.columns.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| ::Rails::Generators::GeneratedAttribute.new(c.name, c.type)}
        rescue NoMethodError
          @model_name.constantize.fields.collect{|c| c[1]}.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| ::Rails::Generators::GeneratedAttribute.new(c.name, c.type.to_s)}
        end
      end

      def extract_modules(name)
        modules = name.include?('/') ? name.split('/') : name.split('::')
        name    = modules.pop
        path    = modules.map { |m| m.underscore }
        file_path = (path + [name.underscore]).join('/')
        nesting = modules.map { |m| m.camelize }.join('::')
        [name, path, file_path, nesting, modules.size]
      end

      def generate_views
        views = {
          "index.html.#{ext}"   => File.join('app/views', @controller_file_path, "index.html.#{ext}"),
          "new.html.#{ext}"     => File.join('app/views', @controller_file_path, "new.html.#{ext}"),
          "edit.html.#{ext}"    => File.join('app/views', @controller_file_path, "edit.html.#{ext}"),
          "_form.html.#{ext}"   => File.join('app/views', @controller_file_path, "_form.html.#{ext}"),
          "show.html.#{ext}"    => File.join('app/views', @controller_file_path, "show.html.#{ext}")}
        selected_views = views
        options.engine == generate_erb(selected_views)
      end

      def generate_erb(views)
        views.each do |template_name, output_path|
          template template_name, output_path
        end
      end

      def ext
        ::Rails.application.config.generators.options[:rails][:template_engine] || :erb
      end

      def generate_controller
        template "controller.rb", "app/controllers/#{@controller_file_path}_controller.rb"
      end
      
      def generate_locale_file
        root = { 'en' => {}}
        locale = root['en']
        (@controller_class_path+[@base_name]).each do |namespace|
          locale[namespace] = {}
          locale = locale[namespace]
        end
        #index
        locale['index'] = {
          'title' => "#{resource_name.titleize}s",
          'new' => "New #{resource_name.titleize}",
          'headers' => {}
        }
        columns.each do |column|
          locale['index']['headers'][column.name] = column.name.humanize
        end
        
        #edit
        locale['edit'] = {
        }
        
        #new
        locale['new'] = {
        }

        #form
        locale['form'] = {
          "edit_title" => "Edit #{resource_name.titleize}",
          "new_title" => "New #{resource_name.titleize}"
        }
        
        #show
        locale['show'] = {
          "title" => "#{resource_name.titleize} Details",
          'labels' => {}
        }
        columns.each do |column|
          locale['show']['labels'][column.name] = column.name.humanize
        end
        
        create_file "config/locales/en/#{@controller_file_path}.yml", root.to_yaml
        
      end

    end
  end
end




