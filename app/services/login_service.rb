class LoginService
  attr_accessor :phone

  def initialize(phone)
    @phone = phone
  end

  def login
    data = { student: { phone_number: phone } }
    # data[:registration] = data.dup
    post('api/students/initiate_phone_validation.json', data)
  end

  def validate_code(code)
    data = { student: { phone_number: phone, phone_verification_code: code } }
    # data[:registration] = data.dup
    post('api/students.json', data)
  end

  # TODO: needs error handling for timeouts etc.
  def post(url, data)
    url = "#{base_url}/#{url}"
    uri = URI(url)
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = base_url.downcase.starts_with?('https:')
    req = Net::HTTP::Post.new(uri,
                              'Content-Type' => 'application/json',
                              'X-User-Token' => 'Zeemee')
    req.body = data.to_json
    https.request(req)
  end

  # TODO: move to ENV
  def base_url
    'http://host.docker.internal:3000'
    # 'https://www.zaptack.com'
    # 'https://www.zeemee.com'
  end
end
