class LoginService
  attr_accessor :phone

  def initialize(phone)
    @phone = phone
  end

  def login
    url = "#{base_url}/api/students/initiate_phone_validation.json"
    uri = URI(url)
    data = {
      student: { phone_number: phone },
      registration: { student: { phone_number: phone } }
    }
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.use_ssl = true
    req.body = data.to_json
    res = https.request(req)
    # res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    #   http.request(req)
    # end
    #JSON.parse(res)
    res
  end

  def base_url
    #'https://www.zeemee.com'
    'http://localhost:3000'
  end
end
