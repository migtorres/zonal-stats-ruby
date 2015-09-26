require 'spec_helper'
require 'rspec/mocks'

describe ZonalStats do
  let(:zonal_stats) { ZonalStats.new}

  context "#read_raster" do

    it 'opens raster' do
      geotransform = [-180, 0.005, 0.0, 90, 0.0, -0.005]
      raster_file = 'raster_file.tif'
      raster = double("raster")
      raster.should_receive(:get_geotransform).and_return(geotransform)
      #raster.should_receive(:get_raster_band).with(1)
      Gdal::Gdal.should_receive(:open).with('raster_file.tif').and_return(raster)
      zonal_stats.read_raster(raster_file: 'raster_file.tif')
    end

    it 'gets raster band'

    it 'sets no data value'
    it 'gets geo transform'
  end

  context "bounding box" do

    it 'gets bounding box to pixel' do
      geotransform = [-180, 0.005, 0.0, 90, 0.0, -0.005]
      vector_extent = [0, 0, 50, 50]
      bbox_to_pixel = zonal_stats.bbox_to_pixel_offsets(geotransform: geotransform, vector_extent: vector_extent)
      bbox_to_pixel.should == { x1: 36000, y1: 8000, xsize: 1, ysize: 1 }
    end
  end

  context "#read_vector" do
    it 'opens vector' do
      vector_file = 'vector_file.geojson'
      vector = double("vector")
      vector.should_receive(:get_layer).with(0)
      Gdal::Ogr.should_receive(:open).with(vector_file).and_return(vector)
      zonal_stats.read_vector(vector_file: vector_file)
    end

  end
end
