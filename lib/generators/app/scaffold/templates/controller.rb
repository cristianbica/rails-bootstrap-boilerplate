class <%= @base_name.camelize %>Controller < InheritedResources::Base
  has_scope :page, :default => 1
  actions :all
  load_and_authorize_resource

<% if options[:singleton] -%>
  defaults :singleton => true
<% end -%>

  protected
  def build_resource
    super.tap do |resource|
    end
  end

end
