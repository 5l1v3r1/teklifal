module ApplicationHelper

  def desc desc
    sanitize desc, tags: %w(br strong em del a h1 blockquote pre ul ol li div),
      attributes: %w(href)
  end

  def full_title page_title
    page_title.empty? ? t('common.site_name') : "#{page_title} - #{t('common.site_name')}".html_safe
  end

  def title title
    provide :title, title
  end

  def page_header title
    render 'page_header', title: title
  end

  def sub_header title
    render 'sub_header', title: title
  end

  def nav_link(title, path, options = {})
    classes = ["nav-link"]
    classes << "active" if current_page?(path)
    options.merge!(class: classes.join(" "))
    link_to title, path, options
  end

  def humanize_attribute object, attribute
    object = object.class.name.underscore unless object.kind_of? Symbol
    I18n.t("activerecord.attributes.#{object}.#{attribute}")
  end

  def google_map_url_for latitude:, longitude:
    "https://www.google.com/maps/?q=#{latitude},#{longitude}"
  end
end
