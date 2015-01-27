from archer import Archer
from utils.zeus import zeus_client
from config import (
    ZEUS,
    LOG
)

import inspect
import time
import logging
import sys


def test_error_handler(meta, result):
    logger.exception('Exception occured')
    #if isinstance(result.error, zeus_client.constants['ers'].ERSUserException):
    error = result.error
    raise meta.app.thrift.ERSSystemException(error.error_code, error.error_name, error.message)
        

def zeus_log(meta):
    logger.info('service: {}, api name: {}, args: {}'.format('ers',meta.name,meta.args))

def zeus_log_result(meta,result):
    if result.error == None:
        logger.info('service: {}, api name: {}, result: {}'.format('ers',meta.name,result.result))
        logger.info('service: {}, response time: {}'.format('ers',result.end_time-meta.start_time))
    else: 
        logger.exception('service: {}, api name: {}, result: {}'.format('ers',meta.name,result.error.error_name))
        logger.exception('service: {}, response time: {}'.format('ers',result.end_time-meta.start_time))

app = Archer(__name__)
zeus_client.read_config(ZEUS)

log_config = LOG

stdout_handler = logging.StreamHandler(sys.stdout)
#stderr_handler = logging.StreamHandler(sys.stderr)
stdout_handler.setFormatter(logging.Formatter(
    log_config['format']
))
#stderr_handler.setFormatter(logging.Formatter(
    #log_config['format']
#))

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(stdout_handler)
#logger.addHandler(stderr_handler)

app.register_error_handler(
    zeus_client.constants['ers'].ERSSystemException,
    test_error_handler)

app.before_api_call(zeus_log)
app.tear_down_api_call(zeus_log_result)

zeus_ers_methods = zeus_client['ers'].service.thrift_services

for zeus_ers_method in zeus_ers_methods:
    app.api(zeus_ers_method)(getattr(zeus_client['ers'],zeus_ers_method))

if __name__ == '__main__':
    app.run()

"""@app.api('ping')
def ping():
    #return zeus_client['eus'].ping()
    return 'pong'

@app.api('update_region_and_its_group')
def update_region_and_its_group(region_id, region, group_id):
    return zeus_client['ers'].update_region_and_its_group(region_id, region, group_id)

@app.api('walle_update_mobile_and_name')
def walle_update_mobile_and_name(user_id, mobile, name):
    return zeus_client['eus'].walle_update_mobile_and_name(
            user_id, mobile, name)

@app.api('test_error_handler')
def test_error():
    raise TException"""
