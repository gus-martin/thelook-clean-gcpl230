# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    link: {
      label: "other Dashboard"
      url: "google.com"
    }
    sql: ${sale_price} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }

  dimension: is_completed_sale{
    type: yesno
    sql: ${sale_price}>2 ;;
  }

  measure: total_sale_price_3 {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: "usd"
    #drill_fields: [order_details_drill*]

    filters: {
      field: is_completed_sale
      value: "yes"
    }

    link: {
      label: "Show Event Summary"
      url: "
      @{generate_link_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign filters_mapping = 'order_items.created_date|users.age' %}
      {% assign drill_fields = 'orders.created_month,orders.id,users.age,users.id,users.name,orders.status,orders.order_amount' %}
      {% assign different_explore = false %}
      {% assign target_model = 'thelook-clean' %}
      {% assign target_explore = 'order_items' %}
      @{generate_explore_link}
      "
    }
  }

  measure: total_sale_price2 {
    type: sum
    sql: ${sale_price};;
    drill_fields: [my_set*]
    required_fields: [users.age]

    html:
    {% if value > 800 %}
      <span style="color:darkgreen;">{{ rendered_value }}</span>
    {% else %}
      <span style="color:darkred;">{{ rendered_value }}</span>
    {% endif %} ;;

    link: {
      label: "Load Explore"
      url: "/explore/thelook-clean/order_items?fields=orders.created_month,users.age,orders.id,orders.status&f[users.age]={{ users.age._rendered_value }}&sorts=orders.created_month+desc&limit=500"
      }
  }

  set: my_set {
    fields: [total_sale_price, id]
  }

}
