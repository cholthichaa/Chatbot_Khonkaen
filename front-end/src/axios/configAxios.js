const configAxios = (method, url, data) => {
    data = data || {};
    const config = {
      method: method, 
      url: url,
      headers: { 
        Authorization: `Bearer ${localStorage.getItem('accessToken')}`,
      },
      data: data,
    };
    return config;
  };
  
  export default configAxios;