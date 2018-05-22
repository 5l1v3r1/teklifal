module ApplicationHelper

  def desc desc
    sanitize desc, tags: %w(br strong em del a h1 blockquote pre ul ol li),
      attributes: %w(href)
  end
end
