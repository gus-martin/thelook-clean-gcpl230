- dashboard: testdashboard
  title: testdashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  tile_size: 100

  filters:

  elements:
    - name: add_a_unique_name_1682283389
      title: Untitled Visualization
      model: thelook-clean
      explore: order_items
      type: looker_grid
      fields: [order_items.total_sale_price_3, users.age]
      sorts: [order_items.total_sale_price_3 desc]
      limit: 500
      column_limit: 50
      show_view_names: false
      show_row_numbers: true
      transpose: false
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      size_to_fit: true
      table_theme: white
      limit_displayed_rows: false
      enable_conditional_formatting: false
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      show_sql_query_menu_options: false
      show_totals: true
      show_row_totals: true
      truncate_header: false
      series_cell_visualizations:
        order_items.total_sale_price_3:
          is_active: false
      defaults_version: 1
