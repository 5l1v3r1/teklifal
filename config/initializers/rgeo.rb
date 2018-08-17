# FACTORY = RGeo::Geographic.simple_mercator_factory

# RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
#   config.default = FACTORY.projection_factory
#   config.register(RGeo::Geographic.spherical_factory(srid: 4326), geo_type: "point")
# end