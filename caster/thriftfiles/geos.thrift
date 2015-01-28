# define geos service
namespace php GEOS
namespace py geos

/**
 * Const
 */
const i16 DEFAULT_LIST_SIZE = 100
const i16 MAX_LIST_SIZE = 1000

/**
 * Enums
 */

/**
 * Types and Structs
 */
typedef i64 Timestamp
typedef i64 Geohash
typedef string Json
/**
 *  restaurant deliver_amount pair
 */
typedef map<i32, double> RestaurantDa

struct TGeohashName {
    1: required i64 geohash,
    2: required i32 is_filled,
    3: required i32 city_id,
    4: required i32 district_id,
    5: required string name,
    6: required string address,
    7: required string pguid,
    8: required Timestamp created_at,
    9: required i32 is_manually,
    10: required bool online_payment,
}

struct TRrcRegion {
    1: optional i32 id,
    2: optional string name,
    3: optional i32 region_id,
    4: optional string area,
    5: optional Timestamp created_at,
    6: optional bool is_premium,
    7: optional bool has_fixed_ranking
}

struct TRrcRegionQuery {
    1: optional list<i32> region_ids,
    2: optional string name,
    3: optional i32 offset,
    4: optional i32 limit,
    5: optional bool is_premium,
}

struct TRrcRegionRanking {
    1: optional i32 id,
    2: optional i32 rrc_region_id,
    3: required i32 restaurant_id,
    4: required i32 ranking,
}

struct TRrcRegionRankingPr {
    1: optional i32 id,
    2: optional i32 rrc_region_id,
    3: required i32 restaurant_id,
    4: required i32 ranking,
    5: required Timestamp created_at,
}

struct TPoi {
    1: optional i32 id,
    2: optional string name,
    3: optional string address,
    4: optional double latitude,
    5: optional double longitude,
    6: optional string pguid,
    7: optional string psn,
    8: optional string city,
    9: optional string info_json,
    10: optional i32 city_id,
}

struct TDasRestaurant {
    1: required list<RestaurantDa> normal_restaurants,
    2: required list<RestaurantDa> premium_restaurants,
}


/**
 * Exceptions
 */
enum GEOSErrorCode {
    UNKNOWN_ERROR,

    // User Errors
    INVALID_RESTAURANT_AREA,
    INVALID_REGION_AREA,
    INVALID_RRC_REGION_AREA,
    REGION_AREA_TOO_LARGE,
    RESTAURANT_AREA_TOO_LARGE,
    RRC_REGION_AREA_TOO_LARGE,
    CL_RRC_REGION_NOT_FOUND,
    RRC_REGION_NOT_FOUND,
    REGION_NOT_FOUND,
    GEOHASH_NAME_NOT_FOUND,
    GEOHASH_RESTAURANT_NOT_FOUND,
    RRC_REGION_OUT_OF_PARENT_REGION,
    CANT_REMOVE_RRC_REGION_HAS_FIXED_RANKING,
    CONFLICT_WITH_OTHER_RRC_REGION,
    CANT_MODIFY_REGION_ID,
    POI_NOT_FOUND,
    QUERY_AREA_TOO_LARGE,

    POI_NAME_EMPTY,
    POI_ADDRESS_EMPTY,
    POI_CITY_EMPTY,
    POI_LOC_EMPTY,
    POI_PGUID_AUTOMATICALLY,
    POI_PSN_AUTOMATICALLY,
    PSN_AND_PGUID_READ_ONLY,
    GEOHASH_NOT_VALID,
    NO_PGUID_IN_POI,
    INVALID_LAT_LON,


    // System Errors
    INVALID_FIELD_VALUE,
    DATABASE_ERROR,
    ERS_CLIENT_ERROR,
    TASK_REVOKE,
    CRAWL_POI_ERROR,
}

exception GEOSUserException {
    1: required GEOSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception GEOSSystemException {
    1: required GEOSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception GEOSUnknownException {
    1: required GEOSErrorCode error_code,
    2: required string error_name,
    3: required string message,
}


/**
 * Services
 */
service GeohashService {
    /**
     * Base APIs
     */

    bool ping()
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    map<string, i32> mcount_restaurant_by_position(1: list<string> positions)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    map<i64, i32> mcount_restaurant_by_geohash(1: list<Geohash> geohashes)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    map<i64, i32> get_geohash_region_map(1: list<i64> geohashes)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    i32 support_online_payment(1:i64 geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),


    /**
     * Apps APIs
     */
    i32 save_rrc_region(1:i32 rrc_region_id, 2:TRrcRegion rrc_region)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void post_rrc_ranking(1:i32 rrc_region_id,
                          2:map<i32, i32> ranking_map,
                          3:i32 user_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    /**
     * Inner APIs
     */
    double get_restaurant_deliver_amount(1:i32 restaurant_id, 2:i64 geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<RestaurantDa> get_restaurant_das(1:i64 geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<RestaurantDa> get_restaurant_das_by_psn(1:string psn,
                                                 2:bool is_premium)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<RestaurantDa> get_restaurant_das_by_position(1:double latitude,
                                                      2:double longitude)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<RestaurantDa> get_premium_restaurant_das(1:i64 geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TDasRestaurant get_all_restaurant_das(1:i64 geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void post_update_restaurant_deliver_geojson(1:i32 cl_restaurant_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void post_update_rrc_region_area(1:i32 cl_rrc_region_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void remove_rrc_region(1:i32 rrc_region_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void post_update_region_area(1:i32 cl_region_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void post_delete_region(1:i32 dl_region_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void crawl_all_geohashes(1:i32 step)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void crawl_geohashes(1:list<i64> geohashes)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void crawl_poi(1:string pguid)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    i32 save_poi(1:i32 poi_id, 2:TPoi t_poi)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    # deprecated, use msave_poi instead
    void msave_poi_by_pguid(1:list<TPoi> t_pois)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    void msave_poi(1:list<TPoi> t_pois)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),
    /**
     * Query APIs
     */
    list<i32> query_restaurant_ids_by_geohash(1:Geohash geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TGeohashName get_geohash_name(1: Geohash geohash_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    i32 count_rrc_region(1:TRrcRegionQuery query_struct)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<TRrcRegion> query_rrc_region(1:TRrcRegionQuery query_struct)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<TRrcRegion> query_rrc_region_use_geo(1:TRrcRegionQuery query_struct)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TRrcRegion get_rrc_region(1:i32 rrc_region_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<TRrcRegionRanking> query_rrc_region_ranking(1:i32 rrc_region_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    i32 get_region_id(1: Geohash geohash)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    i32 get_region_id_by_point(1: string latitude,
                               2: string longitude)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TPoi master_get_poi(1: i32 poi_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TPoi get_poi(1: i32 poi_id)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TPoi get_poi_by_pguid(1: string pguid)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TPoi get_poi_by_psn(1: string psn)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    list<TPoi> mget_poi_by_psn(1: list<string> psn_list)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TPoi get_poi_by_loc(1: double lat,
                        2: double lon)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),

    TPoi get_poi_by_name(1: double lat,
                         2: double lon,
                         3: string name)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),


    list<TPoi> query_poi_in_box(1: double lat1,
                                2: double lon1,
                                3: double lat2,
                                4: double lon2)
        throws (1: GEOSUserException user_exception,
                2: GEOSSystemException system_exception,
                3: GEOSUnknownException unkown_exception),
}
