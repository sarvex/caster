from archer import Archer
from utils.zeus import zeus_client
from config import ZEUS
from thrift.Thrift import TException
import inspect

app = Archer(__name__)
zeus_client.read_config(ZEUS)

def test_error_handler(meta, result):
    print 'Exception occured'
    if isinstance(result.error, zeus_client.constants['eus'].EUSUserException):
        raise meta.app.thrift.EUSUserException(1, 'sdfsd', 'sdfdsf')
        

def zeus_log(meta):
    print 'zeus_log'

app.register_error_handler(
    TException,
    test_error_handler)

app.before_api_call(zeus_log);

zeus_eus_methods = zeus_client['eus'].service.thrift_services

for zeus_eus_method in zeus_eus_methods:
    app.api(zeus_eus_method)(getattr(zeus_client['eus'],zeus_eus_method))

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
