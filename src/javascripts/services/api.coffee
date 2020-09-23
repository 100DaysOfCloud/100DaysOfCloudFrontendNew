import { ApiBase } from 'dilithium'

class Api extends ApiBase
  namespace: 'api'
  resources:
    users:
      collection:
        intake: 'get'
        account: 'get'
        intake_update: 'post'
        account_update: 'post'
    pages:
      collection:
        home: 'get'
        journeyers: 'get'

api = new Api()
export default api
