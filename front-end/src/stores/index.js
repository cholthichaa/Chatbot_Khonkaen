import { createStore } from 'vuex'

import datafromApiFree from './modules/datafromApiFree'
import places from './modules/places'
import users from './modules/users'
import conversations from './modules/conversations'
import web from './modules/web_ans'
import categories from './modules/categories'

export default createStore({
  state: {},
  getters: {},
  mutations: {},
  actions: {},
  modules: {
    datafromApiFree,
    places,
    users,
    categories,
    conversations,
    web
  }
})
