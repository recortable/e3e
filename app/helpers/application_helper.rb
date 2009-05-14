module ApplicationHelper

  def submit_label_for(model)
    klass = model.class.to_s.downcase
    action = model.new_record? ? 'create' : 'update'
    I18n.t "submit_#{action}_#{klass}"
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def section(label, path, expected = nil, options = {})
    condition = expected ? (controller.class.to_s == expected.to_s) : (path == request.fullpath)
    if condition
      content_tag :span,  label, :class => "active #{controller.class}"
    else
      link_to label, path, options
    end
  end
end
