import axios from 'axios';

const state = {
  dataState: [],
};

const getters = {};

const mutations = {
  SET_DATA: (state, data) => {
    state.dataState = data;
  },
};

const actions = {
  async getDatafromApi({ commit }, data) {
    try {
      const apiBaseUrl = import.meta.env.VITE_APP_API_BASE;
      await axios.post(`${apiBaseUrl}api/data`, data);

      const url = 'https://api.publicapis.org/entries'; // ใช้ URL สำหรับ API ภายนอก
      const res = await axios.get(url);

      commit('SET_DATA', res.data.entries);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters,
};
