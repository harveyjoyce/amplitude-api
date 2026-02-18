with base as (

    select * from {{ ref('base_amplitude__events') }}

),

stg as (

    select
        hash(concat_ws('-', amplitude_id, session_id, event_id, event_time, event_type)) as instance_id,
        --file_name,
        amplitude_id,
        user_id,
        split_part(user_id, '@', 2) as domain_from_user_id,
        device_id,
        ip_address,
        language,
        city,
        region,
        country,
        event_id,
        replace(event_type, '[Amplitude] ', '') as event_type,
        event_time,
        page_counter,
        page_location,
        replace(split_part(regexp_substr(page_location, 'mc_u=.+?&'), '&', 1), 'mc_u=', '') as email_from_url,
        split_part(email_from_url, '@', 2) as domain_from_email_from_url,
        page_domain,
        page_title,
        session_id,
        coalesce(domain_from_user_id, domain_from_email_from_url) as email_domain
    from base
    group by all

)

select *
from stg