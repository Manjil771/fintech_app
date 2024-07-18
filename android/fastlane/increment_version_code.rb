require 'yaml'

def increment_version_code(pubspec_path)
  content = File.read(pubspec_path)
  yaml_content = YAML.load(content)

  version = yaml_content['version']
  version_name, version_code = version.split('+')
  new_version_code = version_code.to_i + 1

  new_version = "#{version_name}+#{new_version_code}"
  yaml_content['version'] = new_version

  File.open(pubspec_path, 'w') { |f| f.write(yaml_content.to_yaml) }

  puts "Version updated to: #{new_version}"
end

pubspec_path = File.join(__dir__, '../..', 'pubspec.yaml')
increment_version_code(pubspec_path)
