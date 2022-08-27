class DbUtils
  class << self
    def db_name
      Rails.configuration
           .database_configuration
        .try(:[], Rails.env)
           .try(:[], 'database')
    end
  end
end
