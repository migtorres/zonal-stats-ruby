require 'spec_helper'

describe ZonalStats do

  it 'Expects reading two arguments' do
    raster = 'raster.tif'
    vector = 'vector.geojson'

    zonal_stats = ZonalStats.new
    zonal_stats.calculate(raster: raster, vector: vector)

  end
end