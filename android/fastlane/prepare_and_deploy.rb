#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

def update_pubspec(flavor)
  pubspec_path = File.expand_path('../../pubspec.yaml', __dir__)
  pubspec = YAML.load_file(pubspec_path)

  # Uncomment the asset line for the specified flavor
  pubspec['flutter']['assets'].map! do |asset|
    if asset.include?(flavor) && asset.start_with?('#')
      asset.sub('#', '')
    else
      asset
    end
  end

  # Write the updated pubspec back to the file
  File.write(pubspec_path, pubspec.to_yaml)
end

def update_env_dart(flavor)
  env_path = File.expand_path('../../lib/common/constant/env.dart', __dir__)
  env_content = File.read(env_path)

  # Update the default env configuration
  updated_content = env_content.gsub(
    /static final CoOperative currentCoop = .*Coop;/,
    "static final CoOperative currentCoop = #{flavor}Coop;"
  )

  File.write(env_path, updated_content)
end

def run_fastlane(flavor)
  system("fastlane deploy flavor:#{flavor}")
end

# Main execution
flavor = ARGV[0]

if flavor.nil? || flavor.empty?
  puts "Please provide a flavor as an argument."
  exit 1
end

update_pubspec(flavor)
update_env_dart(flavor)
run_fastlane(flavor)
