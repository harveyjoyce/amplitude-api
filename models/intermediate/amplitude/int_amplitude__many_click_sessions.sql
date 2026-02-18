with stg as (

    select * from {{ ref('stg_amplitude__events') }}

),

--identify sessions with multiple clicks/page views
many_click_sessions as (

    select
        session_id,
        amplitude_id,
        event_type,
        page_title,
        page_location,
        count(distinct instance_id) as cntd_event
    from stg
    where event_type in ('Element Clicked', 'Page Viewed')
    group by all
    having count(distinct instance_id) > 2

),

--filter staging model to only the many click sessions, including the count created above 
full_mcs_data as (
    
    select
        many_click_sessions.cntd_event,
        stg.*
    from many_click_sessions inner join stg
        on many_click_sessions.session_id = stg.session_id
        and many_click_sessions.amplitude_id = stg.amplitude_id
        and many_click_sessions.event_type = stg.event_type
        and many_click_sessions.page_title = stg.page_title
        and many_click_sessions.page_location = stg.page_location

)

select * from full_mcs_data