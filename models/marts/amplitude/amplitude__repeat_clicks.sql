with int as (

    select * from {{ ref('int_amplitude__many_click_sessions') }}

),

--calculate time between events of the same type
time_between_events as (
    
    select
        amplitude_id,
        session_id,
        device_id,
        page_location,
        page_domain,
        page_title,
        event_type,
        event_id,
        cntd_event,
        event_time,
        timestampdiff('seconds', lag(event_time) over(partition by session_id, amplitude_id, event_type order by event_time asc), event_time) as sec_since_last_event
    from int

),

final as (

    --calculate the average time between events in seconds
    select
        hash(concat_ws('-', amplitude_id, session_id, event_type, page_title, page_location)) as pkey, --primary key
        amplitude_id,
        session_id,
        device_id,
        page_location,
        page_domain,
        page_title,
        event_type,
        min(event_time) as session_start_time,
        max(event_time) as session_end_time,
        cntd_event,
        avg(sec_since_last_event) as avg_sec_between_events
    from time_between_events
    group by all
    order by cntd_event desc

)

select * from final