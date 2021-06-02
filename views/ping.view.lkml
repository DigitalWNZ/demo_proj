view: ping {
  sql_table_name: `aftership.ping`
    ;;

  dimension: average {
    type: number
    sql: ${TABLE}.average ;;
  }

  dimension: clientip {
    type: string
    sql: ${TABLE}.clientip ;;
  }

  dimension: lost {
    type: number
    sql: ${TABLE}.lost ;;
  }

  dimension: max {
    type: number
    sql: ${TABLE}.max ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: platform_new {
    type: string
    sql:
      case
        when ${platform}='2' then 'android'
        when ${platform}='3' then 'ios'
      end;;
  }

  measure: sum_lost {
    type: sum
    sql: ${lost} ;;
  }

  measure: avg_lost {
    type: average
    sql: ${lost} ;;
  }

  parameter: metrix_selector {
    type: string
    allowed_value: { value: "sum" }
    allowed_value: { value: "average" }
  }

  measure: metrix {
    label_from_parameter: metrix_selector
    sql:
      CASE
       WHEN {% parameter metrix_selector %} = 'sum' THEN ${sum_lost}
       WHEN {% parameter metrix_selector %} = 'average' THEN ${avg_lost}
       ELSE NULL
      END ;;
  }

  dimension_group: time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
