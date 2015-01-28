# define tds service
namespace php TDS
namespace py tds

/**
 * Const
 */
const i16 DEFAULT_LIST_SIZE = 20
const i16 MAX_LIST_SIZE = 200

/**
 * Enums
 */
enum TDSOrderConst {
    STATUS_UNPROCESSED = 0
    STATUS_SENDING = 10
    STATUS_PROCESSED = 9
    STATUS_CONFIRM = 1
    STATUS_DELIVER = 2
    STATUS_RECEIPT = 3
    STATUS_TOBE_CANCELED = 4
    STATUS_CANCELED = 5

    CANCEL_CODE_NONE = 0
    CANCEL_CODE_OTHER = 1
    CANCEL_CODE_FOOD_SOLDOUT = 2
    CANCEL_CODE_BAD_FOOD = 3
    CANCEL_CODE_CUSTOMER_NOT_CONTACTABLE = 4
    CANCEL_CODE_CUSTOMER_EVIL_REJECT = 5
    CANCEL_CODE_CUSTOMER_BAD_DISTRIBUTION_REJECT = 6
    CANCEL_CODE_ORDER_ADDRESS_OUT_OF_RANGE = 7
    CANCEL_CODE_REPLACE_ORDER = 8
}

enum TDSOrderProcessRecordConst {
    GROUP_SYSTEM = 0,
    GROUP_THIRD_PARTY = 1,
    GROUP_ADMIN = 2,
}


/**
 * Types and Structs
 */
typedef i64 Timestamp


/**
 * Exceptions
 */
enum TDSErrorCode {
    UNKNOWN_ERROR,

    // User Errors
    TDS_DELIVERY_CORP_NOT_FOUND,
    TDS_ORDER_NOT_FOUND,
    TDS_ORDER_NOT_SENDING,
    TDS_RESTAURANT_NOT_FOUND,

    EOS_CLIENT_ERROR,
    ERS_CLIENT_ERROR,

    // System Errors
    SEND_ERROR,
    DATABASE_ERROR,
}

struct TTDSDeliveryCorp {
    1: required i32 id,
    2: required string name,
    3: required string push_url,
    4: required string consumer_key,
    5: required string consumer_secret,
}

struct TTDSDeliveryCorpQuery {
    1: optional i32 offset,
    2: optional i32 limit,
}

struct TTDSOrder {
    1: required i32 id,
    2: required i64 order_id,
    3: required i32 delivery_corp_id,
    4: required i64 delivery_order_id,
    5: required i16 status_code,
    6: required Timestamp created_at,
    7: optional i16 cancel_code,
    8: optional string remark,
}


struct TTDSOrderProcessRecord {
    1: required i32 id,
    2: required i64 order_id,
    3: required i16 from_status,
    4: required i16 to_status,
    5: required string remark,
    6: required i16 courier_id,
    8: required Timestamp created_at,
    9: optional i32 user_id,
    10: optional i16 process_group,
    11: optional i16 delivery_corp_id,
}

struct TTDSOrderQuery {
    1: optional list<i32> dop_user_ids,
    2: optional list<i16> statuses,
    3: optional list<i32> delivery_corp_ids,
    4: optional Timestamp from_datetime,
    5: optional Timestamp to_datetime,
    6: optional i16 limit,
    7: optional list<i32> restaurant_ids,
    8: optional list<i32> exclude_restaurant_ids,
}

exception TDSUserException {
    1: required TDSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception TDSSystemException {
    1: required TDSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception TDSUnknownException {
    1: required TDSErrorCode error_code,
    2: required string error_name,
    3: required string message,
}


/**
 * Services
 */
service ThirdPartyDeliveryService {
    /**
     * Base APIs
     */

    bool ping()
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void clear_cache(1:string api_name,
                     2:list<string> params)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void receive_push_content(1:i64 order_id,
                              2:i16 status,
                              3:string remark,
                              4:i64 delivery_order_id,
                              5:i32 courier_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    list<i64> get_order_ids(1:TTDSOrderQuery query_struct)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),
    /**
     * Apps APIs
     */
    void admin_cancel_order(1:i64 order_id,
                            2:i32 user_id,
                            3:i32 cancel_code,
                            4:string remark)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void admin_confirm_order(1:i64 order_id,
                            2:i32 user_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void admin_receipt_order(1:i64 order_id,
                             2:i32 user_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    /**
     * Inner APIs
     */
    void signal_post_make_order(1:i64 order_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void process_add_tds_order(1:i64 order_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void process_send(1:i32 tds_order_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void process_change_tds_status(1:i64 order_id,
                                   2:i16 to_tds_status,
                                   3:i16 cancel_code,
                                   4:string remark,
                                   5:i32 user_id,
                                   6:i16 process_group)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),
    /**
     * Query APIs
     */
    TTDSOrder get(1:i64 order_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    TTDSDeliveryCorp get_delivery_corp(1:i32 id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    list<TTDSOrder> mget(1:list<i64> order_ids)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    list<TTDSDeliveryCorp> get_delivery_corp_by_restaurant_id(1:i32 rst_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    list<TTDSDeliveryCorp> mget_delivery_corp(1:list<i32> ids)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    list<TTDSDeliveryCorp> get_delivery_corps()
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void update_restaurant_delivery_corp(1: i32 restaurant_id,
                                         2: i32 delivery_corp_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    void remove_restaurant_delivery_corp(1: i32 restaurant_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),

    list<TTDSOrderProcessRecord> query_process_record(1: i64 order_id)
        throws (1: TDSUserException user_exception,
                2: TDSSystemException system_exception,
                3: TDSUnknownException unkown_exception),
}
