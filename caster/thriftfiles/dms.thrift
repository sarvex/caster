# define dms service
namespace php DMS
namespace py dms

/**
 * Const
 */
const i16 MAX_LIST_SIZE = 10000
const i16 DEFAULT_LIST_SIZE = 50
const i16 SORT_TYPE_DESC = 1
const i16 SORT_TYPE_ASC = 2


/**
 * Enums
 */
enum WalleStaffProcessFilterConst {
    DATE_TYPE_DAILY = 1,
    DATE_TYPE_WEEKLY = 2,
    DATE_TYPE_MONTHLY = 3,

    PERIOD_TYPE_15 = 1,
    PERIOD_TYPE_30 = 2,
    PERIOD_TYPE_60 = 3,

    STATS_TYPE_STAFF = 1,
    STATS_TYPE_DEPARTMENT = 2,
}

/**
 * Types and Structs
 */
typedef string Json
typedef i64 Timestamp
typedef i64 Geohash

struct TWalleOverviewFilter {
    1: required string date_start,
    2: required string date_end,
    3: optional list<i32> city_ids,
    4: optional list<i32> region_group_ids,
    5: optional list<i32> region_ids,
    6: optional list<i32> order_modes,
    7: optional list<i16> category_ids,
    8: optional list<i16> come_froms,
    9: optional list<i16> payment_terms,
    10: optional string churn_date_start,
    11: optional string churn_date_end,
    12: optional i32 restaurant_id,
    13: optional list<i32> restaurant_ids,
}

struct TCWalleOverviewSalesOverview {
    1: required double amount,
    2: required double daily_amount,
    3: required double average_price,
    4: required i32 count,
    5: required double daily_count,
    6: required double profit_amount,
    7: required double profit_rate,
    8: required i32 profit_restaurant_count,
    9: required i32 invalid_count,
}

struct TCWalleOverviewSalesDetail {
    1: required string group,
    2: required double amount,
    3: required double amount_rate,
    4: required double daily_amount,
    5: required i32 count,
    6: required double count_rate,
    7: required double daily_count,
    8: required double average_amount,
    9: optional i32 group_id,
}

struct TCWalleOverviewSalesProfitDetail {
    1: required string group,
    2: required double amount,
}

struct TCWalleOverviewUserDetail {
    1: required string group,
    2: required i32 active_user_num,
    3: required i32 new_user_num,
    4: required i32 dup_user_num,
    5: required double dup_user_rate,
    6: required i32 lost_user_num,
    7: required double lost_user_rate,
    8: required double average_amount,
    9: optional i32 group_id
}

struct TCWalleOverviewRestaurantDetail {
    1: required string group,
    2: required i32 napos_num,
    3: required double napos_rate,
    4: required i32 trial_num,
    5: required double trial_rate,
    6: required i32 pay_num,
    7: required double pay_rate,
    8: optional i32 group_id
    9: required i32 temp_free_num,
    10: required double temp_free_rate,
    11: required i32 napos_mobile_num,
    12: required double napos_mobile_rate,
    13: required i32 has_food_img_num,
    14: required double has_food_img_rate,
    15: required i32 online_payment_num,
    16: required double online_payment_rate,
    17: required i32 has_food_activity_num,
    18: required double has_food_activity_rate,
    19: required i32 has_order_num,
    20: required i32 total_num,
}

struct TWalleActivityFilter {
    1: required string date_start,
    2: required string date_end,
    3: optional list<i32> city_ids,
    4: optional list<i32> region_group_ids,
    5: optional list<i32> region_ids,
    6: optional i32 activity_id,
    7: optional i32 restaurant_id,
}

struct TCWalleActivityCouponOverview{
    1: required i32 count,
    2: required double total_amount,
    3: required i32 record_num,
}

struct TCWalleActivityCouponDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required string bankcard_id,
    4: required string cardholder_name,
    5: required string branch_name,
    6: required string bank_name,
    7: required i32 count,
    8: required double total_amount,
}

struct TCWalleActivityExtraDiscountOverview{
    1: required i32 count,
    2: required double total_amount,
    3: required i32 record_num,
}

struct TCWalleActivityExtraDiscountDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required string bankcard_id,
    4: required string cardholder_name,
    5: required string branch_name,
    6: required string bank_name,
    7: required i32 count,
    8: required double total_amount,
}

struct TCWalleActivityFreeGiftOverview{
    1: required i32 count,
    2: required i32 record_num,
}

struct TCWalleActivityFreeGiftDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required string bankcard_id,
    4: required string cardholder_name,
    5: required string branch_name,
    6: required string bank_name,
    7: required i32 count,
}

struct TCWalleFoodActivityOverview{
    1: required i32 count,
    2: required i32 amount,
    3: required i32 record_num,
}

struct TCWalleFoodActivityDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required string bankcard_id,
    4: required string cardholder_name,
    5: required string branch_name,
    6: required string bank_name,
    7: required i32 count,
    8: required double amount,
}

struct TCWalleActivityNewUserDiscountOverview{
    1: required i32 count,
    2: required double total_amount,
    3: required i32 record_num,
}

struct TCWalleActivityNewUserDiscountDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required string bankcard_id,
    4: required string cardholder_name,
    5: required string branch_name,
    6: required string bank_name,
    7: required i32 count,
    8: required double total_amount,
}

struct TCWalleActivityOlpaymentOverview{
    1: required i32 count,
    2: required double total_amount,
    3: required i32 record_num,
}

struct TCWalleActivityOlpaymentDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required string bankcard_id,
    4: required string cardholder_name,
    5: required string branch_name,
    6: required string bank_name,
    7: required i32 count,
    8: required double total_amount,
}

struct TCWalleActivityHalfPriceOverview{
    1: required i32 count,
    2: required double total_amount,
    3: required i32 record_num,
}

struct TCWalleActivityHalfPriceDetail {
    1: required i32 restaurant_id,
    2: required string restaurant_name,
    3: required i32 count,
    4: required double total_amount,
}

struct TCUpdateElement {
    1: required i64 order_id,
    2: required string attribute,
    3: required string old_value,
    4: required string new_value,
}

struct TWalleCouponFilter {
    1: optional i32 batch_id,
}

struct TWalleIncomeFilter {
    1: required string month_start,
    2: required string month_end,
    3: optional list<i32> city_ids,
    4: optional list<i32> region_group_ids,
    5: optional list<i32> region_ids,
    6: optional list<i32> restaurant_ids,
    7: optional list<i16> payment_types,
    8: optional list<i16> plan_types,
    9: optional list<i16> contract_types,
}

struct TCWalleCouponUsageOverview{
    1: required i32 count,
    2: required i32 new_user_num,
    3: required i32 record_num,
}

struct TCWalleCouponUsageDetail {
    1: required string batch_sn,
    2: required i32 batch_id,
    3: required i32 count,
    4: required i32 new_user_num,
    5: required i32 total_num,
    6: required double usage_rate,
}

struct TCWalleIncomeOverview {
    1: required i32 income,
    2: required i32 deduct_income,
    3: required i32 new_contact_income,
    4: required i32 renew_contact_income,
    5: required i32 upgrade_contact_income,
    6: required i32 normal_plan_income,
    7: required i32 ranking_plan_income,
    8: required i32 online_income,
    9: required i32 cash_income,
}

struct TCWalleIncomeDetail {
    1: required string group,
    2: required i32 group_id,
    3: required i32 income,
    4: required i32 deduct_income,
    5: required i32 new_contact_income,
    6: required i32 upgrade_contact_income,
    7: required i32 renew_contact_income,
    8: required i32 normal_plan_income,
    9: required i32 ranking_plan_income,
    10: required i32 online_income,
    11: required i32 cash_income,
}

struct TWalleStaffProcessFilter {
    1: required string day_start,
    2: required string day_end,
    3: optional i16 date_type,
    4: optional i16 period_type,
    5: optional i32 user_id,
    6: optional i16 city_id,
    7: optional list<i16> order_modes,
    8: optional i16 region_type,
}

struct TCWalleOrderProcessDetail {
    1: required string time,
    2: required string user_name,
    3: required i32 dispatched_num,
    4: required i32 processed_num,
    5: required double average_processing_time,
    6: required i32 over_time_num,
    7: required i32 over_time_num_15,
}

struct TCWalleFeedbackProcessStaffDetail {
    1: required string time,
    2: required string user_name,
    3: required i32 processed_num,
    4: required double average_processing_time,
}

struct TCWalleDopUserOnlineDetail {
    1: required string time,
    2: required string user_name,
    3: required i32 online_time,
}


struct TCWalleFeedbackProcessDepartmentDetail {
    1: required string time,
    3: required i32 created_num,
    4: required double average_processing_time,
}

struct TCFeedbackInfo {
    1: required i32 feedback_id,
    2: required Timestamp feedback_at,
    3: required i16 city_id,
    4: required Geohash geohash,
    5: required i32 reply_id,
    6: required Timestamp reply_at,
    7: required i32 reply_by,
}

/**
 * Exceptions
 */
enum DMSErrorCode {
    UNKNOWN_ERROR,
    ORDER_NOT_FOUND,
    DEDUCT_INCOME_OVERFLOW,
    CAlCULATE_INCOME_UPGRADE_BEFORE_ORIGIN,
    SAAS_CONTRACT_STATUS_ERROR,

    // User Errors
    ERS_CLIENT_ERROR,
    EOS_CLIENT_ERROR,
    EUS_CLIENT_ERROR,
    GEOS_CLIENT_ERROR,

    // System Errors
    DATABASE_ERROR,
}

exception DMSUserException {
    1: required DMSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DMSSystemException {
    1: required DMSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DMSUnknownException {
    1: required DMSErrorCode error_code,
    2: required string error_name,
    3: required string message,
}

/**
 * Services
 */
service DataMiningService {
    /**
     * Base APIs
     */
    bool ping()
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<string> get_task_list()
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    void run_task(1: string task_name,
                  2: string start_day,
                  3: string end_day)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),
    /**
     * App service
     */

    TCWalleOverviewSalesOverview walle_overview_sales_overview (
        1: TWalleOverviewFilter filter_struct)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOverviewSalesDetail> walle_overview_sales_detail (
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string sort_key,
        4: i16 sort_type,
        5: i32 offset,
        6: i32 limit)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleOverviewSalesOverview walle_overview_sales_overview_long_cache (
        1: TWalleOverviewFilter filter_struct)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOverviewSalesDetail> walle_overview_sales_detail_long_cache (
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string sort_key,
        4: i16 sort_type,
        5: i32 offset,
        6: i32 limit)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    i32 walle_overview_sales_detail_count (
        1: TWalleOverviewFilter filter_struct,
        2: string group_by)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOverviewSalesProfitDetail> walle_overview_sales_profit_detail (
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string sort_key,
        4: i16 sort_type)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    string walle_overview_sales_chart(
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string name,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    string walle_overview_user_chart(
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string name,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOverviewRestaurantDetail> walle_overview_restaurant_detail (
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string sort_key,
        4: bool is_desc,
        5: i32 offset,
        6: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    i32 walle_overview_restaurant_detail_count (
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleOverviewUserDetail walle_overview_user_overview(
        1: TWalleOverviewFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    i32 walle_overview_user_total_num(
        1: TWalleOverviewFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    i32 walle_overview_user_detail_count(
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string sort_key,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOverviewUserDetail> walle_overview_user_detail(
        1: TWalleOverviewFilter filter_struct,
        2: string group_by,
        3: string sort_key,
        4: i16 sort_type,
        5: i32 offset,
        7: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleActivityCouponOverview walle_activity_coupon_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleActivityCouponDetail> walle_activity_coupon_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleActivityExtraDiscountOverview walle_activity_extra_discount_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleActivityExtraDiscountDetail> walle_activity_extra_discount_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleActivityNewUserDiscountOverview walle_activity_new_user_discount_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleActivityNewUserDiscountDetail> walle_activity_new_user_discount_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleActivityOlpaymentOverview walle_activity_olpayment_discount_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleActivityNewUserDiscountDetail> walle_activity_olpayment_discount_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    Json napos_get_food_stats(1: i32 restaurant_id,
                              2: string from_date,
                              3: string to_date,
                              4: string sort_by)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    Json napos_get_user_stats(1: i32 restaurant_id,
                              2: string from_date,
                              3: string to_date,
                              4: string sort_key,
                              5: bool is_desc,
                              6: i32 limit)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleActivityFreeGiftOverview walle_activity_free_gift_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleActivityFreeGiftDetail> walle_activity_free_gift_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleFoodActivityOverview walle_food_activity_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleFoodActivityDetail> walle_food_activity_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleActivityHalfPriceOverview walle_activity_half_price_overview(
        1: TWalleActivityFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleActivityHalfPriceDetail> walle_activity_half_price_detail(
        1: TWalleActivityFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleCouponUsageOverview walle_coupon_usage_overview (
        1: TWalleCouponFilter filter_struct)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleCouponUsageDetail> walle_coupon_usage_detail (
        1: TWalleCouponFilter filter_struct,
        2: string sort_key,
        3: bool is_desc,
        4: i32 offset,
        5: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    TCWalleIncomeOverview walle_income_overview(
        1: TWalleIncomeFilter filter_struct)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleIncomeDetail> walle_income_detail(
        1: TWalleIncomeFilter filter_struct,
        2: string group_by,
        3: string sort_key,
        4: bool is_desc,
        5: i32 offset,
        6: i32 limit,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    i32 walle_income_detail_count (
        1: TWalleIncomeFilter filter_struct,
        2: string group_by,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    Json walle_income_trend (
        1: TWalleIncomeFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOrderProcessDetail> walle_staff_order_staff_detail(
        1: TWalleStaffProcessFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleOrderProcessDetail> walle_staff_order_department_detail(
        1: TWalleStaffProcessFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleFeedbackProcessStaffDetail> walle_staff_feedback_staff_detail(
        1: TWalleStaffProcessFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleFeedbackProcessDepartmentDetail> walle_staff_feedback_department_detail(
        1: TWalleStaffProcessFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    list<TCWalleDopUserOnlineDetail> walle_staff_online_staff_detail(
        1: TWalleStaffProcessFilter filter_struct,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    /**
     * Inner APIs
     */
     void update_eleme_order_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_active_user_daily_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_active_user_history_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_activity_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_napos_order_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_restaurant_food_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_napos_restaurant_food_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_coupon_usage_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_napos_user_stats(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void saas_check_trials()
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void calculate_saas_income(1: string sn)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void remove_saas_income(1: string sn)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    void dop_user_add_process_type_change_record(
        1: i32 user_id,
        2: i32 created_at,
        3: i16 from_type,
        4: i16 to_type,
    )
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void dop_user_update_online_stats(1: string day)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_order_process_fact(1: list<TCUpdateElement> update_list)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_order_process_stats(1: list<i64> order_ids)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_feedback_process_fact(1: list<TCFeedbackInfo> feedback_infos)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_feedback_process_fact_by_id(1: i32 feedback_id)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

     void update_feedback_process_stats(1: list<i32> feedback_ids)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    /**
     * Signal APIs
     */
    void signal_post_update_order(1: list<TCUpdateElement> update_elements)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    void signal_post_process_order(1: i32 order_process_record_id)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),

    void signal_post_process_napos_order(1: i32 order_process_record_id)
        throws (1: DMSUserException user_exception,
                2: DMSSystemException system_exception,
                3: DMSUnknownException unknown_exception),
}
