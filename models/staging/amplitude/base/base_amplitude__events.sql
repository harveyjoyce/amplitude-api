with source as (

    select * from {{ source('amplitude', 'amplitude_events_raw') }}

),

parsed as (

    select
        file_name,
        json_data:amplitude_id::varchar as amplitude_id,
        json_data:user_id::varchar as user_id,
        json_data:device_id::varchar as device_id,
        json_data:ip_address::varchar as ip_address,
        json_data:language::varchar as language,
        json_data:city::varchar as city,
        json_data:region::varchar as region,
        json_data:country::varchar as country,
        json_data:event_id::int as event_id,
        json_data:event_type::varchar as event_type,
        to_timestamp(json_data:event_time) as event_time,
        json_data:event_properties:"[Amplitude] Page Counter"::int as page_counter,
        json_data:event_properties:"[Amplitude] Page Location"::varchar as page_location,
        json_data:event_properties:"[Amplitude] Page Domain"::varchar as page_domain,
        json_data:event_properties:"[Amplitude] Page Title"::varchar as page_title,
        json_data:session_id::int as session_id
    from source

)

select * from parsed