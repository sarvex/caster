from archer import Archer
from utils.zeus import zeus_client
from config import ZEUS

app = Archer(__name__)
zeus_client.read_config(ZEUS)

def test_error_handler(meta,result):
    print 'Exception occured'
    raise meta.app.thrift.EUSUserException(1, 'sdfsd', 'sdfdsf')
        

app.register_error_handler(zeus_client.constants['eus'].EUSUserException,test_error_handler)

@app.api('ping')
def ping():
    return zeus_client['eus'].ping()

@app.api('update_region_and_its_group')
def update_region_and_its_group(region_id,region,group_id):
    return zeus_client['ers'].update_region_and_its_group(region_id,region,group_id)

@app.api('walle_update_mobile_and_name')
def walle_update_mobile_and_name(user_id,mobile,name):
    return zeus_client['eus'].walle_update_mobile_and_name(
            user_id,mobile,name)

@app.api('test_error_handler')
def test_error():
    raise TException
