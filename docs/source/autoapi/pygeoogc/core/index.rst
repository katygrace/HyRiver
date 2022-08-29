:py:mod:`pygeoogc.core`
=======================

.. py:module:: pygeoogc.core

.. autoapi-nested-parse::

   Base classes and function for REST, WMS, and WMF services.



Module Contents
---------------

.. py:class:: ArcGISRESTfulBase(base_url, layer = None, outformat = 'geojson', outfields = '*', crs = DEF_CRS, max_workers = 1, verbose = False, disable_retry = False)

   Access to an ArcGIS REST service.

   :Parameters: * **base_url** (:class:`str`, *optional*) -- The ArcGIS RESTful service url. The URL must either include a layer number
                  after the last ``/`` in the url or the target layer must be passed as an
                  argument.
                * **layer** (:class:`int`, *optional*) -- Target layer number, defaults to None. If None layer number must be
                  included as after the last ``/`` in ``base_url``.
                * **outformat** (:class:`str`, *optional*) -- One of the output formats offered by the selected layer. If not correct
                  a list of available formats is shown, defaults to ``geojson``.
                  It defaults to ``esriSpatialRelIntersects``.
                * **outfields** (:class:`str` or :class:`list`) -- The output fields to be requested. Setting ``*`` as outfields requests
                  all the available fields which is the default setting.
                * **crs** (:class:`str`, *optional*) -- The spatial reference of the output data, defaults to EPSG:4326
                * **max_workers** (:class:`int`, *optional*) -- Max number of simultaneous requests, default to 2. Note
                  that some services might face issues when several requests are sent
                  simultaneously and will return the requests partially. It's recommended
                  to avoid using too many workers unless you are certain the web service
                  can handle it.
                * **verbose** (:class:`bool`, *optional*) -- If True, prints information about the requests and responses,
                  defaults to False.
                * **disable_retry** (:class:`bool`, *optional*) -- If ``True`` in case there are any failed queries, no retrying attempts
                  is done and object IDs of the failed requests is saved to a text file
                  which its path can be accessed via ``self.failed_path``.

   .. py:method:: esri_query(geom, geo_crs = DEF_CRS)

      Generate geometry queries based on ESRI template.


   .. py:method:: get_features(featureids, return_m = False, return_geom = True)

      Get features based on the feature IDs.

      :Parameters: * **featureids** (:class:`list`) -- List of feature IDs.
                   * **return_m** (:class:`bool`, *optional*) -- Whether to activate the Return M (measure) in the request,
                     defaults to ``False``.
                   * **return_geom** (:class:`bool`, *optional*) -- Whether to return the geometry of the feature, defaults to ``True``.

      :returns: :class:`dict` -- (Geo)json response from the web service.


   .. py:method:: get_response(url, payloads, method = 'GET')

      Send payload and get the response.


   .. py:method:: initialize_service()

      Initialize the RESTFul service.


   .. py:method:: partition_oids(oids)

      Partition feature IDs based on ``self.max_nrecords``.


   .. py:method:: retry_failed_requests()

      Retry failed requests.



.. py:class:: RESTValidator(**data)



   Validate ArcGISRESTful inputs.

   :Parameters: * **base_url** (:class:`str`, *optional*) -- The ArcGIS RESTful service url. The URL must either include a layer number
                  after the last ``/`` in the url or the target layer must be passed as an argument.
                * **layer** (:class:`int`, *optional*) -- Target layer number, defaults to None. If None layer number must be included as after
                  the last ``/`` in ``base_url``.
                * **outformat** (:class:`str`, *optional*) -- One of the output formats offered by the selected layer. If not correct
                  a list of available formats is shown, defaults to ``geojson``.
                * **outfields** (:class:`str` or :class:`list`) -- The output fields to be requested. Setting ``*`` as outfields requests
                  all the available fields which is the default setting.
                * **crs** (:class:`str`, *optional*) -- The spatial reference of the output data, defaults to EPSG:4326
                * **max_workers** (:class:`int`, *optional*) -- Max number of simultaneous requests, default to 2. Note
                  that some services might face issues when several requests are sent
                  simultaneously and will return the requests partially. It's recommended
                  to avoid using too many workers unless you are certain the web service
                  can handle it.
                * **verbose** (:class:`bool`, *optional*) -- If True, prints information about the requests and responses,
                  defaults to False.
                * **disable_retry** (:class:`bool`, *optional*) -- If ``True`` in case there are any failed queries, no retrying attempts
                  is done and object IDs of the failed requests is saved to a text file
                  which its path can be accessed via ``self.failed_path``.


.. py:class:: WFSBase(**data)



   Base class for WFS service.

   :Parameters: * **url** (:class:`str`) -- The base url for the WFS service, for examples:
                  https://hazards.fema.gov/nfhl/services/public/NFHL/MapServer/WFSServer
                * **layer** (:class:`str`) -- The layer from the service to be downloaded, defaults to None which throws
                  an error and includes all the available layers offered by the service.
                * **outformat** (:class:`str`) --

                  The data format to request for data from the service, defaults to None which
                   throws an error and includes all the available format offered by the service.
                * **version** (:class:`str`, *optional*) -- The WFS service version which should be either ``1.0.0``, ``1.1.0``, or
                  ``2.0.0``. Defaults to ``2.0.0``.
                * **crs** (:class:`str`, *optional*) -- The spatial reference system to be used for requesting the data, defaults to
                  ``epsg:4326``.
                * **read_method** (:class:`str`, *optional*) -- Method for reading the retrieved data, defaults to ``json``. Valid options are
                  ``json``, ``binary``, and ``text``.
                * **max_nrecords** (:class:`int`, *optional*) -- The maximum number of records in a single request to be retrieved from the service,
                  defaults to 1000. If the number of requested records is greater than this value,
                  the query will be split into multiple requests.

   .. py:method:: get_validnames()

      Get valid column names for a layer.


   .. py:method:: validate_wfs()

      Validate input arguments with the WFS service.



.. py:class:: WMSBase(**data)



   Base class for accessing a WMS service.

   :Parameters: * **url** (:class:`str`) -- The base url for the WMS service e.g., https://www.mrlc.gov/geoserver/mrlc_download/wms
                * **layers** (:class:`str` or :class:`list`) -- A layer or a list of layers from the service to be downloaded. You can pass an empty
                  string to get a list of available layers.
                * **outformat** (:class:`str`) -- The data format to request for data from the service. You can pass an empty
                  string to get a list of available output formats.
                * **version** (:class:`str`, *optional*) -- The WMS service version which should be either 1.1.1 or 1.3.0, defaults to 1.3.0.
                * **crs** (:class:`str`, *optional*) -- The spatial reference system to be used for requesting the data, defaults to
                  ``epsg:4326``.

   .. py:method:: get_validlayers()

      Get the layers supported by the WMS service.


   .. py:method:: validate_wms()

      Validate input arguments with the WMS service.



.. py:function:: validate_version(val, valid_versions)

   Validate version from a list of valid versions.

   :Parameters: * **val** (:class:`str`) -- Input version value.
                * **valid_versions** (:class:`list` of :class:`str`) -- List of valid versions.

   :returns: :class:`str` -- Validated version value.


