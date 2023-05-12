from archer import Archer
from utils.zeus import zeus_client
from config import (
    ZEUS,
    LOG,
    ZEUS_SERVICE,
    ZEUS_USR_EXCEPTION,
    ZEUS_SYS_EXCEPTION,
)

from handlers import (
    SysExceptionHandler,
    UserExceptionHandler,
    zeus_before_api_call,
    zeus_after_api_call,
)

import time
import logging
import sys

class Caster(Archer):
    zeus_service_list = ZEUS_SERVICE
    usr_exception_list = ZEUS_USR_EXCEPTION
    sys_exception_list = ZEUS_SYS_EXCEPTION
    log_config = LOG

    def registe_api_from_zeus(self, zeus_service):
        zeus_methods = zeus_client[zeus_service].service.thrift_services
        for zeus_method in zeus_methods:
            self.api(zeus_method)(getattr(zeus_client[zeus_service],zeus_method))

    def registe_zeus_error_handler(self,zeus_service):
        self.register_error_handler(
            getattr(
                zeus_client.constants[zeus_service],
                self.usr_exception_list[zeus_service]
            ),
            UserExceptionHandler)
        self.register_error_handler(
            getattr(
                zeus_client.constants[zeus_service],
                self.sys_exception_list[zeus_service]
            ),
            SysExceptionHandler)
    
    def init_log_config(self,zeus_service):
        stdout_handler = logging.StreamHandler(sys.stdout)
        stdout_handler.setFormatter(logging.Formatter(
            self.log_config['format']
        ))
        self.logger = logging.getLogger(zeus_service)
        self.logger.setLevel(logging.INFO)
        self.logger.addHandler(stdout_handler)

    def registe_api_log_call(self):
        self.before_api_call(zeus_before_api_call)
        self.tear_down_api_call(zeus_after_api_call)

    def init(self, zeus_service):
        if zeus_service not in self.zeus_service_list:
            raise KeyError('service not found')
        zeus_client.read_config(ZEUS)
        self.registe_api_from_zeus(zeus_service)
        self.registe_zeus_error_handler(zeus_service)
        self.init_log_config(zeus_service)
        self.registe_api_log_call()

app = Caster(__name__)
if __name__ == '__main__':
    app.init('ers')
    app.run()

