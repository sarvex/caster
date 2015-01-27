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
        'format': '%(asctime)s %(levelname)s [%(name)s]: %(message)s'
                          ' [in %(pathname)s:%(lineno)d]',
        'level': logging.INFO,
    }

ZEUS_SERVICE = [
        'dms',
        'ees',
        'eos',
        'ers',
        'ess',
        'eus',
        'geos',
        'oas',
        'sms',
        'tds',
        'wps',
    ]

ZEUS_USR_EXCEPTION = {
        'dms': 'DMSUserException',
        'ees': 'EESUserException',
        'eos': 'EOSUserException',
        'ers': 'ERSUserException',
        'ess': 'ESSUserException',
        'eus': 'EUSUserException',
        'geos': 'GEOSUserException',
        'oas': 'OASUserException',
        'sms': 'SMSUserException',
        'tds': 'TDSUserException',
        'wps': 'WPSUserException',
    }


ZEUS_SYS_EXCEPTION = {
        'dms': 'DMSSystemException',
        'ees': 'EESSystemException',
        'eos': 'EOSSystemException',
        'ers': 'ERSSystemException',
        'ess': 'ESSSystemException',
        'eus': 'EUSSystemException',
        'geos': 'GEOSSystemException',
        'oas': 'OASSystemException',
        'sms': 'SMSSystemException',
        'tds': 'TDSSystemException',
        'wps': 'WPSSystemException',
    }
