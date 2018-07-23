class RandomPoint

  def self.generate_from_center_point center:, radius:
    y0 = center[:latitude]
    x0 = center[:longitude]
    rd = radius.to_f / 111300

    u = rand
    v = rand

    w = rd * Math.sqrt(u)
    t = 2 * Math::PI * v
    x = w * Math.cos(t)
    y = w * Math.sin(t)

    { latitude: y + y0, longitude: x + x0 }
  end

  def self.distance point1:, point2:
    lat1, lon1 = point1[:latitude], point1[:longitude]
    lat2, lon2 = point2[:latitude], point2[:longitude]

    big_r = 6371000

    a = 0.5 - 
        Math.cos((lat2 - lat1) * Math::PI / 180) / 2 +
        ( Math.cos(lat1 * Math::PI / 180) *
          Math.cos(lat2 * Math::PI / 180) *
          (1 - Math.cos((lon2 - lon1) * Math::PI / 180)) /
          2)
    
    big_r * 2 * Math.asin(Math.sqrt(a))
  end
end