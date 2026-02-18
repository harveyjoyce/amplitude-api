{%- macro dynamic_pivot(our_model, groupby, header_col, value_col, aggregation ='SUM') -%}

--depends_on: {{ref(our_model)}}
{% if execute %}

{% set values = dbt_utils.get_column_values(table=ref(our_model), column=header_col) %}

select
 {% if groupby != '' %}
 {{groupby}},
 {% endif %}
 {% for value in values %}
 {{aggregation}}(case when {{header_col}}='{{value}}' then {{value_col}} else 0 end) as "{{value|replace(' ','_')}}_{{value_col}}"
 {% if not loop.last %},{% endif %}
 {% endfor %}
from {{our_model}}
{% if groupby != '' %}
group by {{groupby}}
{% endif %}
{% endif %}
{% endmacro %}