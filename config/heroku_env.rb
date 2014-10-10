heroku_config_file = File.expand_path('../heroku.yml', __FILE__)
if File.exists?(heroku_config_file)
  config = YAML.load_file(heroku_config_file)

  config_section_name = ENV['HEROKU_ENV'] || Rails.env
  config_section = config.fetch(config_section_name, {})

  overriden_config_file = File.expand_path("../heroku_#{config_section_name}.yml", __FILE__)
  if File.exists?(overriden_config_file)
    overriden_config = YAML.load_file(overriden_config_file)
    config_section.merge!(overriden_config)
  end

  config_section.each do |key, value|
    ENV[key.upcase] ||= value.to_s
  end
end
