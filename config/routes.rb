Myapp::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root to: 'landing#index'

  # All routes

  #costs routes
  get "costs/enroll"
  get "costs/create"
  get "costs/index"
  get "costs/request_create"
  get "costs/payment_check/:id", to: 'costs#payment_check'
  get "costs/getinfo"
  get "costs/balance"
  get "costs/edit_payment/:id", to: 'costs#edit_payment'

  #emplyees routes
  get "employees/index"
  get "employees/duty"
  get "employees/semester"
  get "employees/team_create"
  get "employees/delete/:id", to: 'employees#delete'
  get "employees/semester_team/:id", to: 'employees#semester_team'
  get "employees/employee_new"
  get "employees/employee_edit/:id", to: 'employees#employee_edit'
  post "employees/employee_create"
  get "employees/employee_update/:id", to: 'employees#employee_update'
  get "employees/employee_edit/:id", to:'employees#employee_edit'

  #files routes
  get "files/index"
  get "files/data"

  #accounts routes
  get "accounts/account_new"
  get "accounts/account_create"
  get "accounts/account_index"
  get "accounts/account_open"
  post "accounts/account_update"
  get "accounts/cashbuy_create"

  #orders routes
  get "orders/order_open"
  get "orders/order_index"
  get "orders/order_manage"
  get "orders/order_list"
  get "orders/user_point"
  get "orders/find_user"
  get "orders/order_create"
  get "orders/order_cancle/:id", to: 'orders#order_cancle'
  get "orders/make_confirm/:id", to:'orders#make_confirm'
  get "orders/order_confirm/:id", to:'orders#order_confirm'
  get "orders/order_delete/:id", to:'orders#order_delete'

  # mateiral routes
    #기본재료
  get "materials/new"
  get "materials/index"
  get "materials/edit/:id", to: 'materials#edit'
  get "materials/update/:id", to: 'materials#update'
  post "materials/create"
  get "materials/delete/:id", to: 'materials#delete'
   
    #재고체크관련
  get "materials/check"
  get "materials/check_index"
  get "materials/check_create"
  get "materials/check_edit"
  get "materials/check_update"
  get "materials/edit_price"

    #구매관련
  get "materials/request_buy"
  get "materials/material_price"

  # user routes
  post "users/login_process"
  get "users/logout"
  get "users/index"
  post "users/create"
  post "users/find_user"
  get "users/money/:id", to: 'users#money'
  get "users/user_cs"
  get "users/total_cs"
  get "users/cs_create"
  get "users/offline_cs_create"
  get "users/cs_complete"
  get "users/check_email"
  get "users/check_number"
  get "users/user_rate"
  post "users/update/:id", to: 'users#update'

  # menu routes
    #메뉴관련
  get "menus/new"
  get "menus/index"
  get "menus/edit/:id", to: 'menus#edit'
  get "menus/delete/:id", to: 'menus#delete'
  post "menus/update/:id", to: 'menus#update'
  post "menus/create"
  get "menus/engineering"

    #레시피관련
  get "menus/recipe_new"
  get "menus/recipe_create"
  get "menus/recipe_index/:id", to: 'menus#recipe_index'
  get "menus/recipe_edit/:id", to: 'menus#recipe_edit'
  post "menus/recipe_update/:id", to: 'menus#recipe_update'

  # 기본 템플릿 routes
  get "dashboards/dashboard_1"
  get "dashboards/dashboard_2"
  get "dashboards/dashboard_3"
  get "dashboards/dashboard_4"
  get "dashboards/dashboard_4_1"
  get "dashboards/dashboard_5"
  get "dashboards/neulpum_dashboard"
  get "dashboards/marketing_dashboard"
  get "dashboards/day_revenue"

  get "pages/search_results"
  get "pages/lockscreen"
  get "pages/invoice"
  get "pages/invoice_print"
  get "pages/login"
  get "pages/login_2"
  get "pages/forgot_password"
  get "pages/register"
  get "pages/not_found_error"
  get "pages/internal_server_error"
  get "pages/empty_page"
  get "pages/confirm_duplication"
  get "pages/edit/:id", to: 'pages#edit'


  get "landing/index"

end
