module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def section(label, path, options = {})
    if path == request.fullpath
      content_tag :span,  label, :class => "active #{controller.class}"
    else
      link_to label, path, options
    end
  end
end
