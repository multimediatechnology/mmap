# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Major.create([
               {name: 'Audio'},
               {name: 'Computeranimation'},
               {name: 'Film'}
             ])

Setting.create([
                 {name: 'start', value: '2018-04-16 00:00:00'},
                 {name: 'end', value: '2018-04-20 23:59:00'}
               ])
