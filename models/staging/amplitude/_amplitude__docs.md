{% docs file_name %}
  The name of the file from which the data was loaded in
{% enddocs %}

{% docs amplitude_id %}
  Unique identifier for the user. Fewer nulls than for user_id
{% enddocs %}

{% docs user_id %}
  Unique identifier for the user. Often null - only defined if the user logs in
{% enddocs %}

{% docs device_id %}
  The id of the device being used to access the site
{% enddocs %}

{% docs ip_address %}
  The ip address from which the site is being accessed
{% enddocs %}

{% docs language %}
  The language in which the user is viewing the site
{% enddocs %}

{% docs city %}
  The city from which the site is being viewed
{% enddocs %}

{% docs region %}
  The region from which the site is being viewed
{% enddocs %}

{% docs country %}
  The country from which the site is being viewed
{% enddocs %}

{% docs event_id %}
  Should be a unique id for each event within each session for each user. Sometimes duplicated
{% enddocs %}

{% docs event_type %}
  The action performed (e.g. element clicked, page viewed, etc.)
{% enddocs %}

{% docs event_time %}
  The time at which the action was performed
{% enddocs %}

{% docs page_counter %}
  The number of pages viewed in the session
{% enddocs %}

{% docs page_location %}
  The url of the page on the site being viewed
{% enddocs %}

{% docs page_domain %}
  The domain of the site. Can indicate the sites for each TIL country
{% enddocs %}

{% docs page_title %}
  The name of the page being viewed
{% enddocs %}

{% docs session_id %}
  Represents the number of milliseconds since epoch (UTC) of when the first event of the session occurs
{% enddocs %}

{% docs instance_id %}
  A unique event identifier created by hashing amplitude_id, session_id, event_id, event_time, and event_type
{% enddocs %}

{% docs domain_from_user_id %}
  The email domain parsed from the user_id (which is an email address)
{% enddocs %}

{% docs email_from_url %}
  The email address parsed from the url (embedded if the user reached the site via a marketing link)
{% enddocs %}

{% docs email_domain %}
  Combination of domain_from_email_from_url and domain_from_user_id, filling in nulls from each with values from the other
{% enddocs %}

{% docs pkey %}
  The primary key. This was created by hashing amplitude_id, session_id, and event_type
{% enddocs %}

{% docs session_start_time %}
  The timestamp for when the session began
{% enddocs %}

{% docs session_end_time %}
  The timestamp for when the session ended
{% enddocs %}

{% docs cntd_event %}
  The distinct count of events of that event type on that page of the site for the session
{% enddocs %}

{% docs avg_sec_between_events %}
  The average seconds between events of the same type on the same page. If this is low, it could indicate confusion about the layout of the site (because the user is clicking around frequently)
{% enddocs %}