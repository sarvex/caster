# define wps service
namespace php WPS
namespace py wps

/**
 * Const
 */
const i16 DEFAULT_LIST_SIZE = 20
const i16 MAX_LIST_SIZE = 200

/**
 * Enums
 */

/**
 * Types and Structs
 */
typedef i64 Timestamp

struct TWirelessOrderSend {
    1: required i32 id,
    2: required i64 order_id,
    3: required string order_no,
    4: required string wireless_printer_esn,
    5: required string content,
    6: required i16 status,
    7: required Timestamp created_at,
    8: required i16 is_confirmed,
}

struct TWirelessOrderSendQuery {
    1: optional i32 limit,
    2: optional i32 offset,
    3: optional list<i64> order_ids,
    4: optional list<string> order_nos,
    5: optional string wireless_printer_esn,
    6: optional list<i32> statuses,
}


/**
 * Exceptions
 */
enum WPSErrorCode {
    UNKNOWN_ERROR,

    // User Errors
    WIRELESS_ORDER_HAS_NOT_CONFIRMED,
    WIRELESS_ORDER_RECEIVE_PUSH_INFO_INVALID,
    WIRELESS_ORDER_SEND_NOT_FOUND,
    WIRELESS_ORDER_SEND_ALREADY_PROCESSED,
    INVALID_RESTAURANT_NUMBER,

    EOS_CLIENT_ERROR,
    ERS_CLIENT_ERROR,

    // System Errors
    DATABASE_ERROR,
    PROCESS_SEND_ERROR,
    PROCESS_RECEIVE_ERROR,
}

exception WPSUserException {
    1: required WPSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception WPSSystemException {
    1: required WPSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception WPSUnknownException {
    1: required WPSErrorCode error_code,
    2: required string error_name,
    3: required string message,
}


/**
 * Services
 */
service WirelessPrintService {
    /**
     * Base APIs
     */

    bool ping()
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    void clear_cache(1:string api_name,
                     2:list<string> params)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    void send(1:i64 order_id)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    void receive_push(1:string content)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    /**
     * Apps APIs
     */

    /**
     * Inner APIs
     */
    void signal_post_make_order(1:i64 order_id)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    void process_send(1:i32 send_id)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    void process_receive_and_confirm(1:i32 send_id)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    /**
     * Query APIs
     */

     TWirelessOrderSend get_wireless_order_send(1: i64 order_id)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    list<TWirelessOrderSend> mget_wireless_order_send(1: list<i64> order_ids)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    i32 count_wireless_order_send(1: TWirelessOrderSendQuery query_struct)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

    list<TWirelessOrderSend> query_wireless_order_send(1: TWirelessOrderSendQuery query_struct)
        throws (1: WPSUserException user_exception,
                2: WPSSystemException system_exception,
                3: WPSUnknownException unkown_exception),

}
