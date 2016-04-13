# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 관리자 아이디 시드데이터
User.create(user_email: 'admin@neoulpum.com', user_name: '늘품지기', password: 'dkemf123', admin: true)


# 카테고리 시드데이터
MenuCategory.create(category_code: '001', category_title: 'coffee')
MenuCategory.create(category_code: '002', category_title: 'tea')
MenuCategory.create(category_code: '003', category_title: 'drink')