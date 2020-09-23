import * as m from 'mithril'

import PagesHome       from 'views/pages/home'
import UsersIntake     from 'views/users/intake'
import UsersAccount    from 'views/users/account'
import PagesJourneyers from 'views/pages/journeyers'

routes =
  '/'           : PagesHome
  '/journeyers' : PagesJourneyers
  '/intake'     : UsersIntake
  '/account'    : UsersAccount

m.route.prefix = ''
m.route document.body, '/', routes

