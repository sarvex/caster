import logging

ZEUS= {
        'client': 'pycy',  # pycy/py/thrift
        'pool': 'base',  # base/heartbeat
        'services': {
            'eos': {
                'host': '127.0.0.1',
                'port': 29090,
            },
            'ers': {
                'host': '127.0.0.1',
                'port': 29091,
            },
            'eus': {
                'host': '127.0.0.1',
                'port': 29098,
            },
            'geos': {
                'host': 'geos_host',
                'port': 29081,
            },
        },
        'lazy_load': False  # True/False
    }

LOG = {
        'format': '%(asctime)s %(levelname)s: %(message)s'
                          ' [in %(pathname)s:%(lineno)d]',
        'level': logging.INFO,
    }
