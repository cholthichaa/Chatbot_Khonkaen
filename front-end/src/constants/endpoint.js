import { baseURL } from "@/axios/baseURL"; 

export const ENDPOINT = {
  PLACES: `${baseURL}/places`,
  USERS: `${baseURL}/users`,  
  CONVERSATIONS: `${baseURL}/conversations`,  
  WEBANS: `${baseURL}/web`, 
  DASHBOARD: `${baseURL}/api/tableCounts/counts`, 
  CATEGORISE: `${baseURL}/categories`, 
  FLEXTOURIST: `${baseURL}/flexmessage`, 
  EVENT: `${baseURL}/events`, 
};

console.log('Base URL:', baseURL);
