SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "ALLOW-FROM www.facebook.com"

  config.csp = {
    default_src: %w(*), # all allowed in the beginning, or try ‘none’
    script_src: %w('self' 'unsafe-inline' connect.facebook.net *.googleapis.com),
    connect_src: %w('self'),
    style_src: %w('self' 'unsafe-inline' *.googleapis.com),
    frame_ancestors: %w('self' www.facebook.com)
  }
end