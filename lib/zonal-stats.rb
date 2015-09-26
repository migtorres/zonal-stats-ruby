require 'gdal'

class ZonalStats
  def read_raster raster_file: raster_file
    raster = Gdal::Gdal.open(raster_file)
    geotransform = geotransform_params(raster: raster)
  end

  def read_vector vector_file: vector_file
    vector = Gdal::Ogr.open(vector_file)
    vector_layer = vector_layer(vector: vector)
  end

  def bbox_to_pixel_offsets(geotransform: geotransform, vector_extent: vector_extent)
    origin_x = geotransform[0]
    origin_y = geotransform[3]
    pixel_width = geotransform[1]
    pixel_height = geotransform[5]
    x1 = ((vector_extent[0] - origin_x) / pixel_width).to_int
    x2 = ((vector_extent[1] - origin_x) / pixel_width).to_int + 1

    y1 = ((vector_extent[3] - origin_y) / pixel_height).to_int
    y2 = ((vector_extent[2] - origin_y) / pixel_height).to_int + 1

    xsize = x2 - x1
    ysize = y2 - y1
    { x1: x1, y1: y1, xsize: xsize, ysize: ysize }
  end

  def geotransform_params raster: raster
    raster.get_geotransform
  end

  def vector_layer vector: vector
    vector.get_layer(0)
  end

end
