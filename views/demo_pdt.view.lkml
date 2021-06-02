view: demo_pdt {
  derived_table: {
    sql: select * from ping where {% condition platform_filter %} ping.platform {% endcondition %}
      ;;
  }

  filter: platform_filter {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: lost {
    type: number
    sql: ${TABLE}.lost ;;
  }

  dimension: average {
    type: number
    sql: ${TABLE}.average ;;
  }

  dimension: max {
    type: number
    sql: ${TABLE}.max ;;
  }

  dimension_group: time {
    type: time
    sql: ${TABLE}.time ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: clientip {
    type: string
    sql: ${TABLE}.clientip ;;
  }

  set: detail {
    fields: [
      total,
      lost,
      average,
      max,
      time_time,
      platform,
      clientip
    ]
  }
}
