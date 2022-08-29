:py:mod:`pynhd.pynhd`
=====================

.. py:module:: pynhd.pynhd

.. autoapi-nested-parse::

   Access NLDI and WaterData databases.



Module Contents
---------------

.. py:class:: NHD(layer, outfields = '*', crs = DEF_CRS)



   Access National Hydrography Dataset (NHD), both meduim and high resolution.

   .. rubric:: Notes

   For more info visit: https://hydro.nationalmap.gov/arcgis/rest/services/nhd/MapServer

   :Parameters: * **layer** (:class:`str`, *optional*) -- A valid service layer. Layer names with ``_hr`` are high resolution and
                  ``_mr`` are medium resolution. Also, layer names with ``_nonconus`` are for
                  non-conus areas, i.e., Alaska, Hawaii, Puerto Rico, the Virgin Islands , and
                  the Pacific Islands. Valid layers are:

                  - ``point``
                  - ``point_event``
                  - ``line_hr``
                  - ``flow_direction``
                  - ``flowline_mr``
                  - ``flowline_hr_nonconus``
                  - ``flowline_hr``
                  - ``area_mr``
                  - ``area_hr_nonconus``
                  - ``area_hr``
                  - ``waterbody_mr``
                  - ``waterbody_hr_nonconus``
                  - ``waterbody_hr``
                * **outfields** (:class:`str` or :class:`list`, *optional*) -- Target field name(s), default to "*" i.e., all the fields.
                * **crs** (:class:`str`, *optional*) -- Target spatial reference, default to ``EPSG:4326``


.. py:class:: NHDPlusHR(layer, outfields = '*', crs = DEF_CRS)



   Access National Hydrography Dataset (NHD) high resolution.

   .. rubric:: Notes

   For more info visit: https://edits.nationalmap.gov/arcgis/rest/services/nhd/MapServer

   :Parameters: * **layer** (:class:`str`, *optional*) -- A valid service layer. Valid layers are:

                  - ``point``
                  - ``sink``
                  - ``flowline``
                  - ``non_network_flowline``
                  - ``flow_direction``
                  - ``line``
                  - ``wall``
                  - ``burn_line``
                  - ``burn_waterbody``
                  - ``area``
                  - ``waterbody``
                  - ``huc12``
                  - ``catchment``
                * **outfields** (:class:`str` or :class:`list`, *optional*) -- Target field name(s), default to "*" i.e., all the fields.
                * **crs** (:class:`str`, *optional*) -- Target spatial reference, default to ``EPSG:4326``


.. py:class:: NLDI

   Access the Hydro Network-Linked Data Index (NLDI) service.

   .. py:method:: comid_byloc(coords, loc_crs = DEF_CRS)

      Get the closest ComID based on coordinates.

      .. rubric:: Notes

      This function tries to find the closest ComID based on flowline grid cells. If
      such a cell is not found, it will return the closest ComID using the flowtrace
      endpoint of the PyGeoAPI service to find the closest downstream ComID. The returned
      dataframe has a ``measure`` column that indicates the location of the input
      coordinate on the flowline as a percentage of the total flowline length.

      :Parameters: * **coords** (:class:`tuple` or :class:`list` of :class:`tuples`) -- A tuple of length two (x, y) or a list of them.
                   * **loc_crs** (:class:`str`, *optional*) -- The spatial reference of the input coordinate, defaults to EPSG:4326.

      :returns: :class:`geopandas.GeoDataFrame` or :class:`(geopandas.GeoDataFrame`, :class:`list)` -- NLDI indexed ComID(s) and points in EPSG:4326. If some coords don't return
                any ComID a list of missing coords are returned as well.


   .. py:method:: feature_byloc(coords, loc_crs = DEF_CRS)

      Get the closest feature ID(s) based on coordinates.

      :Parameters: * **coords** (:class:`tuple` or :class:`list`) -- A tuple of length two (x, y) or a list of them.
                   * **loc_crs** (:class:`str`, *optional*) -- The spatial reference of the input coordinate, defaults to EPSG:4326.

      :returns: :class:`geopandas.GeoDataFrame` or :class:`(geopandas.GeoDataFrame`, :class:`list)` -- NLDI indexed feature ID(s) and flowlines in EPSG:4326. If some coords don't
                return any IDs a list of missing coords are returned as well.


   .. py:method:: get_basins(feature_ids, fsource = 'nwissite', split_catchment = False, simplified = True)

      Get basins for a list of station IDs.

      :Parameters: * **feature_ids** (:class:`str` or :class:`list`) -- Target feature ID(s).
                   * **fsource** (:class:`str`) -- The name of feature(s) source, defaults to ``nwissite``.
                     The valid sources are:

                     * 'comid' for NHDPlus comid.
                     * 'ca_gages' for Streamgage catalog for CA SB19
                     * 'gfv11_pois' for USGS Geospatial Fabric V1.1 Points of Interest
                     * 'huc12pp' for HUC12 Pour Points
                     * 'nmwdi-st' for New Mexico Water Data Initative Sites
                     * 'nwisgw' for NWIS Groundwater Sites
                     * 'nwissite' for NWIS Surface Water Sites
                     * 'ref_gage' for geoconnex.us reference gages
                     * 'vigil' for Vigil Network Data
                     * 'wade' for Water Data Exchange 2.0 Sites
                     * 'WQP' for Water Quality Portal
                   * **split_catchment** (:class:`bool`, *optional*) -- If ``True``, split basins at their outlet locations. Default to ``False``.
                   * **simplified** (:class:`bool`, *optional*) -- If ``True``, return a simplified version of basin geometries. Default to ``True``.

      :returns: :class:`geopandas.GeoDataFrame` or :class:`(geopandas.GeoDataFrame`, :class:`list)` -- NLDI indexed basins in EPSG:4326. If some IDs don't return any features
                a list of missing ID(s) are returned as well.


   .. py:method:: get_validchars(char_type)

      Get all the available characteristics IDs for a given characteristics type.


   .. py:method:: getcharacteristic_byid(comids, char_type, char_ids = 'all', values_only = True)

      Get characteristics using a list ComIDs.

      :Parameters: * **comids** (:class:`str` or :class:`list`) -- The NHDPlus Common Identifier(s).
                   * **char_type** (:class:`str`) -- Type of the characteristic. Valid values are ``local`` for
                     individual reach catchments, ``tot`` for network-accumulated values
                     using total cumulative drainage area and ``div`` for network-accumulated values
                     using divergence-routed.
                   * **char_ids** (:class:`str` or :class:`list`, *optional*) -- Name(s) of the target characteristics, default to all.
                   * **values_only** (:class:`bool`, *optional*) -- Whether to return only ``characteristic_value`` as a series, default to True.
                     If is set to False, ``percent_nodata`` is returned as well.

      :returns: :class:`pandas.DataFrame` or :class:`tuple` of :class:`pandas.DataFrame` -- Either only ``characteristic_value`` as a dataframe or
                or if ``values_only`` is Fale return ``percent_nodata`` as well.


   .. py:method:: getfeature_byid(fsource, fid)

      Get feature(s) based ID(s).

      :Parameters: * **fsource** (:class:`str`) -- The name of feature(s) source. The valid sources are:

                     * 'comid' for NHDPlus comid.
                     * 'ca_gages' for Streamgage catalog for CA SB19
                     * 'gfv11_pois' for USGS Geospatial Fabric V1.1 Points of Interest
                     * 'huc12pp' for HUC12 Pour Points
                     * 'nmwdi-st' for New Mexico Water Data Initative Sites
                     * 'nwisgw' for NWIS Groundwater Sites
                     * 'nwissite' for NWIS Surface Water Sites
                     * 'ref_gage' for geoconnex.us reference gages
                     * 'vigil' for Vigil Network Data
                     * 'wade' for Water Data Exchange 2.0 Sites
                     * 'WQP' for Water Quality Portal
                   * **fid** (:class:`str` or :class:`list` of :class:`str`) -- Feature ID(s).

      :returns: :class:`geopandas.GeoDataFrame` or :class:`(geopandas.GeoDataFrame`, :class:`list)` -- NLDI indexed features in EPSG:4326. If some IDs don't return any features
                a list of missing ID(s) are returned as well.


   .. py:method:: navigate_byid(fsource, fid, navigation, source, distance = 500, trim_start = False)

      Navigate the NHDPlus database from a single feature id up to a distance.

      :Parameters: * **fsource** (:class:`str`) -- The name of feature(s) source. The valid sources are:

                     * 'comid' for NHDPlus comid.
                     * 'ca_gages' for Streamgage catalog for CA SB19
                     * 'gfv11_pois' for USGS Geospatial Fabric V1.1 Points of Interest
                     * 'huc12pp' for HUC12 Pour Points
                     * 'nmwdi-st' for New Mexico Water Data Initative Sites
                     * 'nwisgw' for NWIS Groundwater Sites
                     * 'nwissite' for NWIS Surface Water Sites
                     * 'ref_gage' for geoconnex.us reference gages
                     * 'vigil' for Vigil Network Data
                     * 'wade' for Water Data Exchange 2.0 Sites
                     * 'WQP' for Water Quality Portal
                   * **fid** (:class:`str`) -- The ID of the feature.
                   * **navigation** (:class:`str`) -- The navigation method.
                   * **source** (:class:`str`, *optional*) -- Return the data from another source after navigating
                     the features using fsource, defaults to None.
                   * **distance** (:class:`int`, *optional*) -- Limit the search for navigation up to a distance in km,
                     defaults is 500 km. Note that this is an expensive request so you
                     have be mindful of the value that you provide. The value must be
                     between 1 to 9999 km.
                   * **trim_start** (:class:`bool`, *optional*) -- If ``True``, trim the starting flowline at the source feature,
                     defaults to ``False``.

      :returns: :class:`geopandas.GeoDataFrame` -- NLDI indexed features in EPSG:4326.


   .. py:method:: navigate_byloc(coords, navigation = None, source = None, loc_crs = DEF_CRS, distance = 500, trim_start = False)

      Navigate the NHDPlus database from a coordinate.

      :Parameters: * **coords** (:class:`tuple`) -- A tuple of length two (x, y).
                   * **navigation** (:class:`str`, *optional*) -- The navigation method, defaults to None which throws an exception
                     if comid_only is False.
                   * **source** (:class:`str`, *optional*) -- Return the data from another source after navigating
                     the features using fsource, defaults to None which throws an exception
                     if comid_only is False.
                   * **loc_crs** (:class:`str`, *optional*) -- The spatial reference of the input coordinate, defaults to EPSG:4326.
                   * **distance** (:class:`int`, *optional*) -- Limit the search for navigation up to a distance in km,
                     defaults to 500 km. Note that this is an expensive request so you
                     have be mindful of the value that you provide. If you want to get
                     all the available features you can pass a large distance like 9999999.
                   * **trim_start** (:class:`bool`, *optional*) -- If ``True``, trim the starting flowline at the source feature,
                     defaults to ``False``.

      :returns: :class:`geopandas.GeoDataFrame` -- NLDI indexed features in EPSG:4326.



.. py:class:: PyGeoAPI



   Access `PyGeoAPI <https://labs.waterdata.usgs.gov/api/nldi/pygeoapi>`__ service.

   .. py:method:: cross_section(coord, width, numpts, crs = DEF_CRS)

      Return a GeoDataFrame from the xsatpoint service.

      :Parameters: * **coord** (:class:`tuple`) -- The coordinate of the point to extract the cross-section as a tuple,e.g., (lon, lat).
                   * **width** (:class:`float`) -- The width of the cross-section in meters.
                   * **numpts** (:class:`int`) -- The number of points to extract the cross-section from the DEM.
                   * **crs** (:class:`str`, *optional*) -- The coordinate reference system of the coordinates, defaults to EPSG:4326.

      :returns: :class:`geopandas.GeoDataFrame` -- A GeoDataFrame containing the cross-section at the requested point.

      .. rubric:: Examples

      >>> from pynhd import PyGeoAPI
      >>> pygeoapi = PyGeoAPI()
      >>> gdf = pygeoapi.cross_section((-103.80119, 40.2684), width=1000.0, numpts=101, crs=DEF_CRS)  # doctest: +SKIP
      >>> print(gdf.iloc[-1, 1])  # doctest: +SKIP
      1000.0


   .. py:method:: elevation_profile(coords, numpts, dem_res, crs = DEF_CRS)

      Return a GeoDataFrame from the xsatendpts service.

      :Parameters: * **coords** (:class:`list`) -- A list of two coordinates to trace as a list of tuples, e.g.,
                     [(lon1, lat1), (lon2, lat2)].
                   * **numpts** (:class:`int`) -- The number of points to extract the elevation profile from the DEM.
                   * **dem_res** (:class:`int`) -- The target resolution for requesting the DEM from 3DEP service.
                   * **crs** (:class:`str`, *optional*) -- The coordinate reference system of the coordinates, defaults to EPSG:4326.

      :returns: :class:`geopandas.GeoDataFrame` -- A GeoDataFrame containing the elevation profile along the requested endpoints.

      .. rubric:: Examples

      >>> from pynhd import PyGeoAPI
      >>> pygeoapi = PyGeoAPI()
      >>> gdf = pygeoapi.elevation_profile(
      ...     [(-103.801086, 40.26772), (-103.80097, 40.270568)], numpts=101, dem_res=1, crs=DEF_CRS
      ... )  # doctest: +SKIP
      >>> print(gdf.iloc[-1, 1])  # doctest: +SKIP
      411.5906


   .. py:method:: flow_trace(coord, crs = DEF_CRS, direction = 'none')

      Return a GeoDataFrame from the flowtrace service.

      :Parameters: * **coord** (:class:`tuple`) -- The coordinate of the point to trace as a tuple,e.g., (lon, lat).
                   * **crs** (:class:`str`) -- The coordinate reference system of the coordinates, defaults to EPSG:4326.
                   * **direction** (:class:`str`, *optional*) -- The direction of flowpaths, either ``down``, ``up``, or ``none``.
                     Defaults to ``none``.

      :returns: :class:`geopandas.GeoDataFrame` -- A GeoDataFrame containing the traced flowline.

      .. rubric:: Examples

      >>> from pynhd import PyGeoAPI
      >>> pygeoapi = PyGeoAPI()
      >>> gdf = pygeoapi.flow_trace(
      ...     (1774209.63, 856381.68), crs="ESRI:102003", direction="none"
      ... )  # doctest: +SKIP
      >>> print(gdf.comid.iloc[0])  # doctest: +SKIP
      22294818


   .. py:method:: split_catchment(coord, crs = DEF_CRS, upstream = False)

      Return a GeoDataFrame from the splitcatchment service.

      :Parameters: * **coord** (:class:`tuple`) -- The coordinate of the point to trace as a tuple,e.g., (lon, lat).
                   * **crs** (:class:`str`, *optional*) -- The coordinate reference system of the coordinates, defaults to EPSG:4326.
                   * **upstream** (:class:`bool`, *optional*) -- If True, return all upstream catchments rather than just the local catchment,
                     defaults to False.

      :returns: :class:`geopandas.GeoDataFrame` -- A GeoDataFrame containing the local catchment or the entire upstream catchments.

      .. rubric:: Examples

      >>> from pynhd import PyGeoAPI
      >>> pygeoapi = PyGeoAPI()
      >>> gdf = pygeoapi.split_catchment((-73.82705, 43.29139), crs=DEF_CRS, upstream=False)  # doctest: +SKIP
      >>> print(gdf.catchmentID.iloc[0])  # doctest: +SKIP
      22294818



.. py:class:: WaterData(layer, crs = DEF_CRS, validation = True)

   Access to `Water Data <https://labs.waterdata.usgs.gov/geoserver>`__ service.

   :Parameters: * **layer** (:class:`str`) -- A valid layer from the WaterData service. Valid layers are:
                  ``nhdarea``, ``nhdwaterbody``, ``catchmentsp``, ``nhdflowline_network``
                  ``gagesii``, ``huc08``, ``huc12``, ``huc12agg``, and ``huc12all``. Note that
                  the layers' worksapce for the Water Data service is ``wmadata`` which will
                  be added to the given ``layer`` argument if it is not provided.
                * **crs** (:class:`str`, *optional*) -- The target spatial reference system, defaults to ``epsg:4326``.
                * **validation** (:class:`bool`, *optional*) -- Whether to validate the input data, defaults to ``True``.

   .. py:method:: bybox(bbox, box_crs = DEF_CRS)

      Get features within a bounding box.


   .. py:method:: bydistance(coords, distance, loc_crs = DEF_CRS)

      Get features within a radius (in meters) of a point.


   .. py:method:: byfilter(cql_filter, method = 'GET')

      Get features based on a CQL filter.


   .. py:method:: bygeom(geometry, geo_crs = DEF_CRS, xy = True, predicate = 'INTERSECTS')

      Get features within a geometry.

      :Parameters: * **geometry** (:class:`shapely.geometry`) -- The input geometry
                   * **geo_crs** (:class:`str`, *optional*) -- The CRS of the input geometry, default to epsg:4326.
                   * **xy** (:class:`bool`, *optional*) -- Whether axis order of the input geometry is xy or yx.
                   * **predicate** (:class:`str`, *optional*) -- The geometric prediacte to use for requesting the data, defaults to
                     INTERSECTS. Valid predicates are:
                     ``EQUALS``, ``DISJOINT``, ``INTERSECTS``, ``TOUCHES``, ``CROSSES``, ``WITHIN``
                     ``CONTAINS``, ``OVERLAPS``, ``RELATE``, ``BEYOND``

      :returns: :class:`geopandas.GeoDataFrame` -- The requested features in the given geometry.


   .. py:method:: byid(featurename, featureids)

      Get features based on IDs.



.. py:function:: geoconnex(item = None, query = None, skip_geometry = False)

   Query the GeoConnex API.

   .. rubric:: Notes

   If you run the function without any arguments, it will print out a list
   of available endpoints. If you run the function with ``item`` but no ``query``,
   it will print out the description, queryable fields, and extent of the
   selected endpoint (``item``).

   :Parameters: * **item** (:class:`str`, *optional*) -- The item to query.
                * **query** (:class:`dict`, *optional*) -- Query parameters. The ``geometry`` field can be a Polygon, MultiPolygon,
                  or tuple/list of length 4 (bbox) in ``EPSG:4326`` CRS.
                * **skip_geometry** (:class:`bool`, *optional*) -- If ``True``, the geometry will not be returned.

   :returns: :class:`geopandas.GeoDataFrame` -- The data.


.. py:function:: pygeoapi(coords, service)

   Return a GeoDataFrame from the flowtrace service.

   :Parameters: * **coords** (:class:`geopandas.GeoDataFrame`) -- A GeoDataFrame containing the coordinates to query.
                  The required columns services are:

                  * ``flow_trace``: ``direction`` that indicates the direction of the flow trace.
                    It can be ``up``, ``down``, or ``none``.
                  * ``split_catchment``: ``upstream`` that indicates whether to return all upstream
                    catchments or just the local catchment.
                  * ``elevation_profile``: ``numpts`` that indicates the number of points to extract
                    along the flowpath and ``3dep_res`` that indicates the target resolution for
                    requesting the DEM from 3DEP service.
                  * ``cross_section``: ``numpts`` that indicates the number of points to extract
                    along the flowpath and ``width`` that indicates the width of the cross-section
                    in meters.
                * **service** (:class:`str`) -- The service to query, can be ``flow_trace``, ``split_catchment``, ``elevation_profile``,
                  or ``cross_section``.

   :returns: :class:`geopandas.GeoDataFrame` -- A GeoDataFrame containing the results of requested service.

   .. rubric:: Examples

   >>> from shapely.geometry import Point
   >>> gdf = gpd.GeoDataFrame(
   ...     {
   ...         "direction": [
   ...             "none",
   ...         ]
   ...     },
   ...     geometry=[sgeom.Point((1774209.63, 856381.68))],
   ...     crs="ESRI:102003",
   ... )
   >>> trace = nhd.pygeoapi(gdf, "flow_trace")
   >>> print(trace.comid.iloc[0])
   22294818


