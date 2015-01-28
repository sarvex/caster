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

def arg_to_str(args):
    log_args = list(args)
    if log_args:
        return ','.join(repr(i) for i in log_args)
    else:
        return ""

def zeus_before_api_call(meta):
    meta.app.logger.info('{}({})'.format(meta.name, arg_to_str(meta.args)))

def zeus_after_api_call(meta,result):
    if result.error == None:
        meta.app.logger.info('{}({}): {}'.format(meta.name, arg_to_str(meta.args), result.result))
        meta.app.logger.info('response time: {}ms'.format((result.end_time-meta.start_time) * 1000))
    else: 
        meta.app.logger.exception('{}({}): {}'.format(meta.name, arg_to_str(meta.args), result.error.error_name))
        meta.app.logger.exception('response time: {}ms'.format((result.end_time-meta.start_time) * 1000))

