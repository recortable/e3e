
Entonces /^debería ver el mensaje (.*)$/ do|message_id|
  id = message_id.slice(1..-1)
  message = qt(:flash, id)
  Entonces %(debería ver "#{message}")
end
