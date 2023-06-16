module AddressHelper
  def self.get_district_from_address(address)
    result = {}
    districts_file = File.read("#{Rails.root}/public/districts.json")
    npu_file = File.read("#{Rails.root}/public/NPU.geojson")
    @districts_hash = JSON.parse(districts_file)
    @npu_hash = JSON.parse(npu_file)
    location = Geocoder.search(address)[0]
    if (location)
      district_id = district_for_point([location.longitude, location.latitude])
      npu = npu_for_point([location.longitude, location.latitude])
      if district_id
        result = { district_id: district_id, npu: npu, address: location.display_name, location: { longitude: location.longitude,
        latitude: location.latitude }, status: "DISTRICT_FOUND"}
      else
        result = { district_id: nil, npu: nil, address: location.display_name, location: { longitude: location.longitude,
                                                                                              latitude: location.latitude }, status: "DISTRICT_NOT_FOUND"}
      end
    else
      result = { district_id: nil, address: nil, location: nil, status: "LOCATION_NOT_FOUND" }
    end
    return result
  end

  def self.contains_point?(point, polygon)
    c = false
    i = -1
    j = polygon.size - 1
    while (i += 1) < polygon.size
      if ((polygon[i][1] <= point[1] && point[1] < polygon[j][1]) ||
          (polygon[j][1] <= point[1] && point[1] < polygon[i][1]))
        if (point[0] < (polygon[j][0] - polygon[i][0]) * (point[1] - polygon[i][1]) /
            (polygon[j][1] - polygon[i][1]) + polygon[i][0])
          c = !c
        end
      end
      j = i
    end
    return c
  end

  def self.district_for_point(point)
    found = nil
    @districts_hash['features'].each do |feature|
      district = feature['geometry']['coordinates'][0]
      if (feature['geometry']['type'].eql?('MultiPolygon'))
        district.each do |sub_district|
          if (contains_point?(point, sub_district))
            found = true
            return feature['properties']['DISTRICT']
          end
        end
      else
        if (contains_point?(point, district))
          found = true
          return feature['properties']['DISTRICT']
        end
      end
    end
    return found
  end

  def self.npu_for_point(point)
    found = nil
    @npu_hash['features'].each do |feature|
      district = feature['geometry']['coordinates'][0]
      if (feature['geometry']['type'].eql?('MultiPolygon'))
        district.each do |sub_district|
          if (contains_point?(point, sub_district))
            found = true
            return feature['properties']['NPU']
          end
        end
      else
        if (contains_point?(point, district))
          found = true
          return feature['properties']['NPU']
        end
      end
    end
    return found
  end
end
