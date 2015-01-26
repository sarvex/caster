from archer import Archer
from utils.zeus import zeus_client
from config import ZEUS
import inspect

app = Archer(__name__)
zeus_client.read_config(ZEUS)

def test_error_handler(meta, result):
    print 'Exception occured'
    #if isinstance(result.error, zeus_client.constants['ers'].ERSUserException):
    error = result.error
    raise meta.app.thrift.ERSSystemException(error.error_code, error.error_name, error.message)
        

def zeus_log(meta):
    print 'zeus_log'
    print meta.name

def zeus_log_result(meta,result):
    if result.error == None:
        print meta.name
        print result.result
    else: 
        print result.error.error_code

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
