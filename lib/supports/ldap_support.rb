module LdapSupport
  LDAP_CONFIG = YAML.load(File.open(Rails.root.join('config', 'ldap.yml')))
  LDAP_HOST = LDAP_CONFIG['host']
  LDAP_BASE = LDAP_CONFIG['base']
  INFO_EXTRACT_KEYS = [:uid, :uidnumber, :gidnumber, :gecos]

  def self.ldap_bind(username, password)
    domain = "uid=#{username},#{LDAP_BASE}"
    ldap = Net::LDAP.new(host: LDAP_HOST, auth: { username: domain, password: password, method: :simple })
    ldap.bind
  end

  def self.ldap_info(username)
    ldap = Net::LDAP.new(host: LDAP_HOST)
    filter = Net::LDAP::Filter.eq('uid', username)
    info = ldap.search(base: LDAP_BASE, filter: filter).first
    return {} if info.blank?

    INFO_EXTRACT_KEYS.each_with_object({}) do |key, object|
      value = info.try(key)
      object[key] = value.size == 1 ? value.first : value
    end
  end
end
