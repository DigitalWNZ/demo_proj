connection: "demo_conn"

# include all the views
include: "/views/**/*.view"

datagroup: demo_proj_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: demo_proj_default_datagroup

explore: ping {
  sql_always_where: ${ping.clientip} is not null;;
  join: ip_by_country {
    type: inner
    sql_on: ${ping.clientip} between ${ip_by_country.start_ip} and ${ip_by_country.end_ip} ;;
    relationship: many_to_one
  }
}

explore: demo_pdt {}

# explore: connection_reg_r3 {}

# explore: ip_by_country {}

# explore: sankey {}
