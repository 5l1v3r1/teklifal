module AdministrationHelper
  def dashboard_nav_link(path, &block)
    options = {}
    classes = ["list-group-item list-group-item-action d-flex justify-content-between align-items-center"]
    classes << "active" if current_page?(path)
    options.merge!(class: classes.join(" "))

    link_to path, options, &block
  end
end
