require 'overpass_api_ruby'
# http://overpass-turbo.eu/s/AyO

# s, w, n, e
# 49.69606181911566,19.033813476562496,50.52041218671901,20.67626953125
module Overpass
  class SyncLocations < BaseTransaction
    E = 20.67626953125
    N = 50.52041218671901
    S = 49.69606181911566
    W = 19.033813476562496
    QUERY = <<QL
<osm-script>
  <union>
    <query type="node">
      <has-kv k="bus" v="yes"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="tram" v="yes"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="railway" v="tram_stop"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="highway" v="bus_stop"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="public_transport" v="stop_area"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="type" v="public_transport"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="public_transport" v="stop_position"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
    <query type="node">
      <has-kv k="public_transport" v="platform"/>
      <bbox-query e="#{E}" n="#{N}" s="#{S}" w="#{W}"/>
    </query>
  </union>
  <union>
    <item/>
    <recurse type="down"/>
  </union>
  <print/>
</osm-script>
QL
    step :fetch_elements
    step :save
    step :try_fix_current_stops

    private

    def fetch_elements(*args)
      overpass = OverpassAPI::XML.new(timeout: 900, element_limit: 1_073_741_824)
      response = overpass.query(QUERY)
      Success(response[:elements])
    end

    def save(elements)
      locations = []
      elements.each do |element|
        tags = element[:tags]
        next unless tags
        
        stop_location = StopLocation.find_or_initialize_by(node_id: element[:id])
        stop_location.location = RGeo::Geos.factory.point(element[:lon], element[:lat])
        stop_location.kind = tags[:tram] == 'yes' ? :tram : :bus
        stop_location.name = tags[:name]&.strip
        locations << stop_location if stop_location.save
      end

      Success(locations)
    end

    def try_fix_current_stops(locations)
      if Version.current
        Version.current.stops.where(lat: nil).each do |stop|
          location = StopLocation.for_stop(stop)
          location&.apply_to(stop)
        end
      end
      Success(locations)
    end
  end
end
