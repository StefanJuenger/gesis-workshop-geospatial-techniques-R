course_content <-
  tibble::tribble(
    ~Day, ~Time, ~Title,
    "February 08", "09:00am-10:30am", "Introduction",
    "February 08", "11:00am-12:30pm", "Vector Data",
    "February 08", "12:30pm-01:30pm", "Lunch Break",
    "February 08", "01:30pm-03:00pm", "Basic Maps",
    "February 08", "03:30pm-05:00pm", "Raster Data",
    "February 09", "09:00am-10:30am", "Advanced Data Import",
    "February 09", "11:00am-12:30pm", "Applied Data Wrangling",
    "February 09", "12:30pm-13:30pm", "Lunch Break",
    "February 09", "01:30pm-03:00pm", "Advanced Maps I",
    "February 09", "03:30pm-05:00pm", "Advanced Maps II"
  ) %>% 
  knitr::kable() %>% 
  kableExtra::kable_styling() %>% 
  kableExtra::column_spec(1, color = "gray") %>% 
  kableExtra::column_spec(2, color = "gray") %>% 
  kableExtra::column_spec(3, bold = TRUE) %>% 
  kableExtra::row_spec(3, color = "gray") %>% 
  kableExtra::row_spec(8, color = "gray") %>% 
  kableExtra::row_spec(5, extra_css = "border-bottom: 1px solid")