module AdminType
  #validation_format
  PHONE_NUMBER_FORMAT = /^(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*$/
  EMAIL_FORMAT  = /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i
end