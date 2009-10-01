begin
  require 'less'
rescue LoadError => e
  e.message << " (You may need to install the less gem)"
  raise e
end

require File.join(File.dirname(__FILE__), 'lib', 'more')

config.after_initialize {
  Less::More.clean
  Less::More.parse if Less::More.page_cache?
}