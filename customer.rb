class Customer
  attr_reader :user_id, :name

  def initialize(latitude:, longitude:, user_id:, name:)
    @latitude = latitude.to_i
    @longitude = longitude.to_i
    @user_id = user_id
    @name = name
  end

  def <=>(other)
    if user_id < other.user_id
      -1
    elsif user_id > other.user_id
      1
    else
      0
    end
  end
end

