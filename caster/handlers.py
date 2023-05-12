def SysExceptionHandler(meta, result):
    meta.app.logger.info('Exception occured')
    error = result.error
    raise getattr(meta.app.thrift, error.__class__.__name__)(
            error.error_code, error.error_name, error.message)

def UserExceptionHandler(meta, result):
    meta.app.logger.info('Exception occured')
    error = result.error
    raise getattr(meta.app.thrift, error.__class__.__name__)(
            error.error_code, error.error_name, error.message)

def zeus_before_api_call(meta):
    meta.app.logger.info(f'{meta.name}({meta.args})')

def zeus_after_api_call(meta,result):
    if result.error is None:
        meta.app.logger.info(f'api name: {meta.name}, result: {result.result}')
        meta.app.logger.info(f'response time: {result.end_time - meta.start_time}')
    else: 
        meta.app.logger.exception(
            f'api name: {meta.name}, result: {result.error.error_name}'
        )
        meta.app.logger.exception(
            f'response time: {result.end_time - meta.start_time}'
        )

