module ApplicationHelper

  def submit_label_for(model)
    #klass = model.class.to_s.downcase
    action = model.new_record? ? 'create' : 'update'
    #I18n.t "submit_#{action}_#{klass}"
    t(action)
  end

  def title(page_title, options = {})
    options = {:show => true, :tag => 'h1'}.update(options)
    content_for(:title) { page_title }
    content_tag(options[:tag], page_title) if options[:show]
  end

  def section(label, path, expected_controller = nil)
    condition = expected_controller ? (controller.class.to_s == expected_controller.to_s) : (path == request.fullpath)
    if condition
      content_tag :span,  label, :class => "active #{controller.class.to_s.downcase}"
    else
      link_to label, path, :class => expected_controller.to_s.downcase
    end
  end
end
