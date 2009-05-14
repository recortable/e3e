
Entonces /^debería ver el mensaje (.*)$/ do|message_id|
  id = message_id.slice(1..-1)
  message = qt(:flash, id)
  Entonces %(debería ver "#{message}")
end

Dado /^que existen las provincias "([^\"]*)"$/ do |list|
  list.split(', ').each do |provincia|
    Provincia.create!(:name => provincia)
  end
end
