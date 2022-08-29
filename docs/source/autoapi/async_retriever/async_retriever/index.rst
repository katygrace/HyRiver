:py:mod:`async_retriever.async_retriever`
=========================================

.. py:module:: async_retriever.async_retriever

.. autoapi-nested-parse::

   Core async functions.



Module Contents
---------------

.. py:function:: delete_url_cache(url, request_method = 'GET', cache_name = None, **kwargs)

   Delete cached response associated with ``url``, along with its history (if applicable).

   :Parameters: * **url** (:class:`str`) -- URL to be deleted from the cache
                * **request_method** (:class:`str`, *optional*) -- HTTP request method to be deleted from the cache, defaults to ``GET``.
                * **cache_name** (:class:`str`, *optional*) -- Path to a file for caching the session, defaults to
                  ``./cache/aiohttp_cache.sqlite``.
                * **kwargs** (:class:`dict`, *optional*) -- Keywords to pass to the ``cache.delete_url()``.


.. py:function:: retrieve(urls, read_method, request_kwds = None, request_method = 'GET', max_workers = 8, cache_name = None, timeout = 5.0, expire_after = EXPIRE, ssl = None, disable = False)

   Send async requests.

   :Parameters: * **urls** (:class:`list` of :class:`str`) -- List of URLs.
                * **read_method** (:class:`str`) -- Method for returning the request; ``binary``, ``json``, and ``text``.
                * **request_kwds** (:class:`list` of :class:`dict`, *optional*) -- List of requests keywords corresponding to input URLs (1 on 1 mapping),
                  defaults to ``None``. For example, ``[{"params": {...}, "headers": {...}}, ...]``.
                * **request_method** (:class:`str`, *optional*) -- Request type; ``GET`` (``get``) or ``POST`` (``post``). Defaults to ``GET``.
                * **max_workers** (:class:`int`, *optional*) -- Maximum number of async processes, defaults to 8.
                * **cache_name** (:class:`str`, *optional*) -- Path to a file for caching the session, defaults to ``./cache/aiohttp_cache.sqlite``.
                * **timeout** (:class:`float`, *optional*) -- Timeout for the request, defaults to 5.0.
                * **expire_after** (:class:`int`, *optional*) -- Expiration time for response caching in seconds, defaults to -1 (never expire).
                * **ssl** (:class:`bool` or :class:`SSLContext`, *optional*) -- SSLContext to use for the connection, defaults to None. Set to False to disable
                  SSL certification verification.
                * **disable** (:class:`bool`, *optional*) -- If ``True`` temporarily disable caching requests and get new responses
                  from the server, defaults to False.

   :returns: :class:`list` -- List of responses in the order of input URLs.

   .. rubric:: Examples

   >>> import async_retriever as ar
   >>> stations = ["01646500", "08072300", "11073495"]
   >>> url = "https://waterservices.usgs.gov/nwis/site"
   >>> urls, kwds = zip(
   ...     *[
   ...         (url, {"params": {"format": "rdb", "sites": s, "siteStatus": "all"}})
   ...         for s in stations
   ...     ]
   ... )
   >>> resp = ar.retrieve(urls, "text", request_kwds=kwds)
   >>> resp[0].split('\n')[-2].split('\t')[1]
   '01646500'


.. py:function:: retrieve_binary(urls, request_kwds = None, request_method = 'GET', max_workers = 8, cache_name = None, timeout = 5.0, expire_after = EXPIRE, ssl = None, disable = False)

   Send async requests and get the response as ``bytes``.

   :Parameters: * **urls** (:class:`list` of :class:`str`) -- List of URLs.
                * **request_kwds** (:class:`list` of :class:`dict`, *optional*) -- List of requests keywords corresponding to input URLs (1 on 1 mapping),
                  defaults to ``None``. For example, ``[{"params": {...}, "headers": {...}}, ...]``.
                * **request_method** (:class:`str`, *optional*) -- Request type; ``GET`` (``get``) or ``POST`` (``post``). Defaults to ``GET``.
                * **max_workers** (:class:`int`, *optional*) -- Maximum number of async processes, defaults to 8.
                * **cache_name** (:class:`str`, *optional*) -- Path to a file for caching the session, defaults to ``./cache/aiohttp_cache.sqlite``.
                * **timeout** (:class:`float`, *optional*) -- Timeout for the request, defaults to 5.0.
                * **expire_after** (:class:`int`, *optional*) -- Expiration time for response caching in seconds, defaults to -1 (never expire).
                * **ssl** (:class:`bool` or :class:`SSLContext`, *optional*) -- SSLContext to use for the connection, defaults to None. Set to False to disable
                  SSL certification verification.
                * **disable** (:class:`bool`, *optional*) -- If ``True`` temporarily disable caching requests and get new responses
                  from the server, defaults to False.

   :returns: :class:`bytes` -- List of responses in the order of input URLs.


.. py:function:: retrieve_json(urls, request_kwds = None, request_method = 'GET', max_workers = 8, cache_name = None, timeout = 5.0, expire_after = EXPIRE, ssl = None, disable = False)

   Send async requests and get the response as ``json``.

   :Parameters: * **urls** (:class:`list` of :class:`str`) -- List of URLs.
                * **request_kwds** (:class:`list` of :class:`dict`, *optional*) -- List of requests keywords corresponding to input URLs (1 on 1 mapping),
                  defaults to ``None``. For example, ``[{"params": {...}, "headers": {...}}, ...]``.
                * **request_method** (:class:`str`, *optional*) -- Request type; ``GET`` (``get``) or ``POST`` (``post``). Defaults to ``GET``.
                * **max_workers** (:class:`int`, *optional*) -- Maximum number of async processes, defaults to 8.
                * **cache_name** (:class:`str`, *optional*) -- Path to a file for caching the session, defaults to ``./cache/aiohttp_cache.sqlite``.
                * **timeout** (:class:`float`, *optional*) -- Timeout for the request, defaults to 5.0.
                * **expire_after** (:class:`int`, *optional*) -- Expiration time for response caching in seconds, defaults to -1 (never expire).
                * **ssl** (:class:`bool` or :class:`SSLContext`, *optional*) -- SSLContext to use for the connection, defaults to None. Set to False to disable
                  SSL certification verification.
                * **disable** (:class:`bool`, *optional*) -- If ``True`` temporarily disable caching requests and get new responses
                  from the server, defaults to False.

   :returns: :class:`dict` -- List of responses in the order of input URLs.

   .. rubric:: Examples

   >>> import async_retriever as ar
   >>> urls = ["https://labs.waterdata.usgs.gov/api/nldi/linked-data/comid/position"]
   >>> kwds = [
   ...     {
   ...         "params": {
   ...             "f": "json",
   ...             "coords": "POINT(-68.325 45.0369)",
   ...         },
   ...     },
   ... ]
   >>> r = ar.retrieve_json(urls, kwds)
   >>> print(r[0]["features"][0]["properties"]["identifier"])
   2675320


.. py:function:: retrieve_text(urls, request_kwds = None, request_method = 'GET', max_workers = 8, cache_name = None, timeout = 5.0, expire_after = EXPIRE, ssl = None, disable = False)

   Send async requests and get the response as ``text``.

   :Parameters: * **urls** (:class:`list` of :class:`str`) -- List of URLs.
                * **request_kwds** (:class:`list` of :class:`dict`, *optional*) -- List of requests keywords corresponding to input URLs (1 on 1 mapping),
                  defaults to ``None``. For example, ``[{"params": {...}, "headers": {...}}, ...]``.
                * **request_method** (:class:`str`, *optional*) -- Request type; ``GET`` (``get``) or ``POST`` (``post``). Defaults to ``GET``.
                * **max_workers** (:class:`int`, *optional*) -- Maximum number of async processes, defaults to 8.
                * **cache_name** (:class:`str`, *optional*) -- Path to a file for caching the session, defaults to ``./cache/aiohttp_cache.sqlite``.
                * **timeout** (:class:`float`, *optional*) -- Timeout for the request in seconds, defaults to 5.0.
                * **expire_after** (:class:`int`, *optional*) -- Expiration time for response caching in seconds, defaults to -1 (never expire).
                * **ssl** (:class:`bool` or :class:`SSLContext`, *optional*) -- SSLContext to use for the connection, defaults to None. Set to False to disable
                  SSL certification verification.
                * **disable** (:class:`bool`, *optional*) -- If ``True`` temporarily disable caching requests and get new responses
                  from the server, defaults to False.

   :returns: :class:`list` -- List of responses in the order of input URLs.

   .. rubric:: Examples

   >>> import async_retriever as ar
   >>> stations = ["01646500", "08072300", "11073495"]
   >>> url = "https://waterservices.usgs.gov/nwis/site"
   >>> urls, kwds = zip(
   ...     *[
   ...         (url, {"params": {"format": "rdb", "sites": s, "siteStatus": "all"}})
   ...         for s in stations
   ...     ]
   ... )
   >>> resp = ar.retrieve_text(urls, kwds)
   >>> resp[0].split('\n')[-2].split('\t')[1]
   '01646500'


.. py:function:: stream_write(urls, file_paths, request_kwds = None, request_method = 'GET', max_workers = 8, ssl = None)

   Send async requests.

   :Parameters: * **urls** (:class:`list` of :class:`str`) -- List of URLs.
                * **file_paths** (:class:`list` of :class:`str` or :class:`~~Path`) -- List of file paths to write the response to.
                * **request_kwds** (:class:`list` of :class:`dict`, *optional*) -- List of requests keywords corresponding to input URLs (1 on 1 mapping),
                  defaults to ``None``. For example, ``[{"params": {...}, "headers": {...}}, ...]``.
                * **request_method** (:class:`str`, *optional*) -- Request type; ``GET`` (``get``) or ``POST`` (``post``). Defaults to ``GET``.
                * **max_workers** (:class:`int`, *optional*) -- Maximum number of async processes, defaults to 8.
                * **ssl** (:class:`bool` or :class:`SSLContext`, *optional*) -- SSLContext to use for the connection, defaults to None. Set to False to disable
                  SSL certification verification.

   .. rubric:: Examples

   >>> import async_retriever as ar
   >>> import tempfile
   >>> url = "https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_500KB_CSV-1.csv"
   >>> with tempfile.NamedTemporaryFile() as temp:
   ...     ar.stream_write([url], [temp.name])


