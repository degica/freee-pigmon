# frozen_string_literal: true

module Freee
  module Pigmon

    @config = {
      freee_client_id: nil,
      freee_client_secret: nil,
      access_token: nil,
      refresh_token: nil,
      expires_at: nil,
      authorize_code: nil,
      company_id: nil,
      employee_id: nil
    }

    @valid_config_keys = @config.keys

    def self.configure(opts = {})
      config
      opts.each do |k, v|
        @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym
      end
      save_config
    end

    def self.get_config_path
      generate_config
      config_path
    end

    def self.generate_config
      Dir.mkdir(config_dir_path) unless Dir.exist? config_dir_path
      FileUtils.touch(config_path) unless File.exist? config_path
    end

    def self.config_dir_path
      Dir.home + '/.freee-pigmon'
    end

    def self.config_path
      config_dir_path + '/settings.yml'
    end

    def self.config
      yml_path = get_config_path
      yml_file = YAML.load_file(yml_path)
      if yml_file
        @config = yml_file
      else
        File.open(yml_path, 'w') { |f| YAML.dump(@config, f) }
      end
    end

    # 現在の@configをyamlに保存
    def self.save_config
      yml_path = get_config_path
      if File.exist?(yml_path)
        File.open(yml_path, 'w') { |f| YAML.dump(@config, f) }
      else
        raise "Can't find #{yml_path}. please set configure."
      end
    end
  end
end
