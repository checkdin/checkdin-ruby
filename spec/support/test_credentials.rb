class TestCredentials
  class << self
    def client_id
      credentials['client_id'] || '123456'
    end

    def client_secret
      credentials['client_secret'] || '7890'
    end

    def api_url
      credentials['api_url'] || Checkdin::Client.new.api_url
    end

    def client_args
      {
        :client_id => client_id,
        :client_secret => client_secret,
        :api_url => api_url
      }
    end

    private

    def credentials
      @credentials ||= begin
        credentials_file = File.expand_path(File.join('..', '..', 'credentials.yml'), __FILE__)
        if File.exist?(credentials_file)
          YAML.load_file(credentials_file)
        else
          {}
        end
      end
    end

  end
end
